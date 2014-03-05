module Devise::MultiAuth
  class AuthenticationsController < Devise::OmniauthCallbacksController

    Devise.omniauth_providers.each do |provider|
      define_method(provider) do
        authentication_from_external_app
      end unless methods.include?(provider)
    end

    private

    def authentication_from_external_app
      omni = request.env["omniauth.auth"]
      if @user = Authentication.find_user_by_provider_and_uid(omni['provider'], omni['uid'])
        set_flash_message(:notice, :success, kind: omni['provider']) if is_navigational_format?
        Devise::MultiAuth.capture_successful_external_authentication( @user, omni)
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.auth_data"] = request.env["omniauth.auth"].except('extra')
        redirect_to new_user_registration_path
      end
    end

  end
end
