require "devise"
require "devise/multi_auth/engine"

module Devise::MultiAuth
  module_function

  def capture_successful_external_authentication(user, auth, config = {})
    service = config.fetch(:service) { CaptureSuccessfulExternalAuthentication }
    service.call(user, auth)
  end

  def oauth_client_for(provider_name, config = {})
    default_args = Devise.omniauth_configs.fetch(provider_name.to_sym).args.dup
    default_options = default_args.extract_options!
    options = config.fetch(:options) { default_options[:client_options] || {} }
    client_id = config.fetch(:client_id) { default_args[0] }
    secret = config.fetch(:secret) { default_args[1] }
    OAuth2::Client.new(client_id, secret, options)
  end

end
