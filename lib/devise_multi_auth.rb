require "devise"
require "devise/multi_auth/engine"

module Devise::MultiAuth
  module_function

  def capture_successful_external_authentication(user, auth, config = {})
    service = config.fetch(:service) { CaptureSuccessfulExternalAuthentication }
    service.call(user, auth)
  end

  def oauth_client_for(provider_name, config = {})
    config_args = Devise.omniauth_configs.fetch(provider_name.to_sym).args.dup
    options = config_args.extract_options!
    client_id = config_args[0]
    secret = config_args[1]
    OAuth2::Client.new(client_id, secret, options[:client_options] || {})
  end

end
