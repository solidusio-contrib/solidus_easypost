# frozen_string_literal: true

require_relative 'lib/solidus_easypost/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_easypost'
  s.version     = Solidus::EasyPost::VERSION
  s.summary     = 'Easy post integration for Solidus'
  s.description = 'Easy post integration for Solidus'
  s.required_ruby_version = '>= 2.2'

  s.author    = 'Brendan Deere'
  s.email     = 'brendan@stembolt.com'
  s.homepage  = 'https://github.com/solidusio-contrib/solidus_easypost'

  # s.files       = `git ls-files`.split("\n")
  # s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency "deface", '~> 1.0'
  s.add_dependency 'easypost'
  s.add_dependency 'solidus', ['>= 1.1', '< 3.x']
  s.add_dependency 'solidus_support', '>= 0.1.1'

  s.add_development_dependency 'capybara', '~> 3.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
