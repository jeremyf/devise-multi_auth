require 'spec_helper'

describe Devise::MultiAuth do

  context '.oauth_client_for' do
    context 'for registered oauth client' do
      let(:provider) { 'github' }
      subject { described_class.oauth_client_for(provider) }
      its(:client_credentials) { should respond_to :get_token }
    end

    context 'for unregistered oauth client' do
      let(:provider) { 'not_github' }
      it 'raises an exception' do
        expect {
          described_class.oauth_client_for(provider)
        }.to raise_error KeyError
      end
    end
  end

  context '.capture_successful_external_authentication' do
    let(:service) { double('Service') }
    let(:user) { double('User') }
    let(:auth) { double('Auth') }
    it 'should delegate to the associated service' do
      service.should_receive(:call).with(user, auth)
      described_class.capture_successful_external_authentication(user, auth, service: service)
    end
  end

end
