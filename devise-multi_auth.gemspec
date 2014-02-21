$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise/multi_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise-multi_auth"
  s.version     = Devise::MultiAuth::VERSION
  s.authors     = ["jeremy.n.friesen@gmail.com"]
  s.email       = ["jeremy.n.friesen@gmail.com"]
  s.homepage    = "https://github.com/jeremyf/devise-multi_auth"
  s.summary     = "A Devise plugin for exposing multiple authentication providers via omniauth."
  s.description = "A Devise plugin for exposing multiple authentication providers via omniauth."

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0.3"
  s.add_dependency "devise", "~> 3.2.2"
  s.add_dependency "omniauth", "~> 1.2.1"

  s.add_development_dependency 'database_cleaner', '1.0.1'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "engine_cart"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "omniauth-github"
  s.add_development_dependency "factory_girl"
end
