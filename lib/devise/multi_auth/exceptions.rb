module Devise::MultiAuth
  class AccessTokenError < RuntimeError
    def initialize(options = {})
      provider = options.fetch(:provider)
      uid = options.fetch(:uid)
      super("#{message_prefix} provider: #{provider.inspect}, uid: #{uid.inspect}.")
    end
    def message_prefix
      "Unspecified access token error for"
    end
  end

  class AccessTokenNotFound < AccessTokenError
    def message_prefix
      "Unable to find access token for"
    end
  end

  class AccessTokenUnverified < AccessTokenError
    "Possible access token found but unverified for"
  end
end
