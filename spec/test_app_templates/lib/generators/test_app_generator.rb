require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "spec/test_app_templates"

  def install_devise_multi_auth
    gem "omniauth-github"
    generate 'devise:multi_auth:install --install_devise --skip_migrate'
  end

  def install_omniauth_strategies
    config_code = ", :omniauthable, :omniauth_providers => [:github]"
    insert_into_file 'app/models/user.rb', config_code, { :after => /:validatable *$/, :verbose => false }

    init_code = %(\n  config.omniauth :github, ENV['GITHUB_APP_ID'], ENV['GITHUB_APP_SECRET'], :scope => 'user,public_repo')
    insert_into_file 'config/initializers/devise.rb', init_code, {after: /Devise\.setup.*$/, verbose: true}
  end

  def install_migrate
    rake 'db:migrate'
  end

end

