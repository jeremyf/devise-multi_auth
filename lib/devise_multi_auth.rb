require "devise"
require "devise/multi_auth/engine"

module Devise::MultiAuth
  module_function

  def capture_successful_external_authentication(user, auth, options = {})
    service = options.fetch(:service) { CaptureSuccessfulExternalAuthentication }
    service.call(user, auth)
  end

end
