require 'spec_helper'

describe Devise::MultiAuth do

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
