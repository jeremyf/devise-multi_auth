require 'rails/generators'

module Devise::MultiAuth
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    class_option :install_devise, default: false, type: :boolean

    def install_devise
      if options[:install_devise]
        generate 'devise:install'
        generate 'devise User'
      end
    end

    def install_authentications_controller
      routing_code = %(, controllers: { omniauth_callbacks: 'devise/multi_auth/authentications' }\n)
      insert_into_file 'config/routes.rb', routing_code, { :after => /devise_for :users/, :verbose => false }
    end

    def install_warden_initializer
      template('devise_multi_auth_initializer.rb.erb', 'config/initializers/devise_multi_auth_initializer.rb')
    end

    def install_migrations
      rake 'devise_multi_auth:install:migrations'
    end
  end
end
