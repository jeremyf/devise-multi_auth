module Devise::MultiAuth
  class CaptureSuccessfulExternalAuthentication
    def self.call(user, auth = {})
      return true unless auth.present?
      new(user, auth).call
    end

    attr_accessor :user, :auth
    def initialize(user, auth)
      @user = user
      @auth = auth
    end

    def call
      object = Authentication.where(user: user).where(auth.slice(:provider, :uid)).first_or_initialize
      object.access_token = auth.fetch(:credentials)[:token]
      object.refresh_token = auth.fetch(:credentials)[:refresh_token]
      object.save!
    end
  end
end
