module Devise::MultiAuth
  class Authentication < ActiveRecord::Base
    belongs_to :user
    self.table_name = 'devise_multi_auth_authentications'

    def self.to_access_token(options)
      uid = options.fetch(:uid)
      client = options.fetch(:client)
      provider = options.fetch(:provider)
      where(provider: provider, uid: uid).first!.to_access_token(client: client)
    rescue ActiveRecord::RecordNotFound
      raise AccessTokenNotFound.new(provider: provider, uid: uid)
    end

    def self.find_user_by_provider_and_uid(provider, uid)
      if auth = find_by_provider_and_uid(provider, uid)
        auth.user
      else
        nil
      end
    end

    def self.find_by_provider_and_uid(provider, uid)
      where(provider: provider, uid: uid).includes(:user).first
    end

    def verified?
      access_token.present?
    end

    def to_access_token(config = {})
      client = config.fetch(:client) { Devise::MultiAuth.oauth_client_for(provider) }
      tokenizer = config.fetch(:tokenizer) { ::OAuth2::AccessToken.method(:new) }
      if verified?
        tokenizer.call(client, access_token, refresh_token: refresh_token)
      else
        raise AccessTokenUnverified.new(provider: provider, uid: uid)
      end
    end
  end
end
