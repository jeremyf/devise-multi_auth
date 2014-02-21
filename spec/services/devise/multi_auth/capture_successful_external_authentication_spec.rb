require 'spec_helper'

module Devise::MultiAuth
  describe CaptureSuccessfulExternalAuthentication do
    context '.call' do
      let(:user) { FactoryGirl.build_stubbed(:devise_multi_auth_user) }
      let(:orcid_profile_id) { '0100-0012' }
      let(:auth) {
        {
          provider: 'orcid',
          uid: orcid_profile_id,
          credentials: {
            token: "453d7dc4-cfed-4e8e-a06d-e035bbb2b835",
            refresh_token: "1ae4a374-d3ac-4e3f-b1b3-72956cc37f49",
            expires_at: 2023450872,
            expires: true
          }
        }
      }

      it 'creates an authentication' do
        CaptureSuccessfulExternalAuthentication.call(user, auth)

        authentication = Authentication.last
        expect(authentication.access_token).to eq auth[:credentials][:token]
        expect(authentication.refresh_token).to eq auth[:credentials][:refresh_token]
      end
    end
  end
end
