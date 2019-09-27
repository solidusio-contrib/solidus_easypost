# frozen_string_literal: true

source 'https://rubygems.org'

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem 'solidus', git: 'https://github.com/solidusio/solidus.git', branch: branch
gem 'solidus_auth_devise'

gem 'factory_bot', (branch < 'v2.5' ? '4.10.0' : '> 4.10.0')

if ENV['DB'] == 'mysql'
  gem 'mysql2', '~> 0.4.10'
else
  gem 'pg', '~> 1.1'
end

gemspec
