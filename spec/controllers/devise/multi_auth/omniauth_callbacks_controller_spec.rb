require 'spec_helper'

module Devise::MultiAuth
  describe OmniauthCallbacksController do
    let(:provider) { :github }
    let(:uid) { '12345' }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.add_mock(provider, {uid: uid, credentials: {}})
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
    end

    context 'GET provider (as callback)' do
      context 'without a registered user' do
        before(:each) do
          Authentication.should_receive(:find_user_by_provider_and_uid).with(provider.to_s, uid).and_return(nil)
        end
        it 'should redirect to signup' do
          get provider
          expect(response).to redirect_to('/users/sign_up')
        end
      end

      context 'with a registered user' do
        let(:user) { FactoryGirl.create(:devise_multi_auth_user) }
        before(:each) do
          Authentication.should_receive(:find_user_by_provider_and_uid).with(provider.to_s, uid).and_return(user)
        end
        # Adding an ID because this request is hitting the database.
        # Trying to figure out why.
        it 'should assign the user and redirect to home' do
          get provider
          expect(flash[:notice]).to_not match(/translation missing/i)
          expect(assigns(:user)).to eq(user)
          expect(response).to be_redirect
        end
      end
    end
  end
end