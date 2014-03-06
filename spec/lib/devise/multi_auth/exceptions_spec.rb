require 'spec_helper'

module Devise::MultiAuth
  describe AccessTokenError do
    let(:parameters) { {provider: 'provider', uid: 'uid' }}
    subject { described_class.new(parameters) }
    it { should be_a_kind_of(AccessTokenError)}
  end

  describe AccessTokenNotFound do
    let(:parameters) { {provider: 'provider', uid: 'uid' }}
    subject { described_class.new(parameters) }
    it { should be_a_kind_of(AccessTokenError)}
  end

  describe AccessTokenUnverified do
    let(:parameters) { {provider: 'provider', uid: 'uid' }}
    subject { described_class.new(parameters) }
    it { should be_a_kind_of(AccessTokenError)}
  end
end
