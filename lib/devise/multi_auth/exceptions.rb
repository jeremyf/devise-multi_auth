module Devise::MultiAuth
  class AccessTokenError < RuntimeError
    def initialize(options = {})
      provider = options.fetch(:provider)
      uid = options.fetch(:uid)
      super("Error with provider: #{provider.inspect}, uid: #{uid.inspect}")
    end
  end

  class AccessTokenNotFound < AccessTokenError
  end

  class AccessTokenUnverified < AccessTokenError
  end
end