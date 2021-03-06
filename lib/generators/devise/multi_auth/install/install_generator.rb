require 'rails/generators'

module Devise::MultiAuth
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    class_option :install_devise, default: false, type: :boolean
    class_option :skip_migrate, default: false, type: :boolean
    class_option :with_omniauth_github, default: false, type: :boolean

    def install_devise
      if options[:install_devise]
        generate 'devise:install'
        generate 'devise User'
      end
    end


    def install_migrations
      rake 'devise_multi_auth:install:migrations'
      if ! options[:skip_migrate]
        rake 'db:migrate'
      end
    end

    def install_authentications_controller
      if options[:with_omniauth_github]
        gem "omniauth-github"
      end
      routing_code = %(, controllers: { omniauth_callbacks: 'devise/multi_auth/omniauth_callbacks' }\n)
      insert_into_file 'config/routes.rb', routing_code, { :after => /devise_for :users/, :verbose => false }
    end
  end

end
