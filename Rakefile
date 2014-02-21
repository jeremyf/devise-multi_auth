begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path("../spec/internal/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

require 'engine_cart/rake_task'

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

namespace :spec do
  desc 'Rebuild and run the specs'
  task :travis => ['engine_cart:clean', 'engine_cart:generate', 'spec']
end