module Devise::MultiAuth
  module CaptureSuccessfulExternalAuthentication
    module_function
    def call(user, auth = {})
      return true unless auth.present?
      where_conditions = { user: user, provider: auth.fetch(:provider), uid: auth.fetch(:uid) }
      object = Authentication.where(where_conditions).first_or_initialize
      object.access_token = auth.fetch(:credentials)[:token]
      object.refresh_token = auth.fetch(:credentials)[:refresh_token]
      object.save!
    end
  end
end
