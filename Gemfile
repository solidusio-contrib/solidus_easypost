# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

solidus_branch = ENV.fetch('SOLIDUS_BRANCH', 'main')
gem 'solidus', github: 'solidusio/solidus', branch: solidus_branch

# The solidus_frontend gem has been pulled out since v3.2
if solidus_branch >= 'v3.2'
  gem 'solidus_frontend'
elsif solidus_branch == 'main'
  gem 'solidus_frontend', github: 'solidusio/solidus_frontend'
else
  gem 'solidus_frontend', github: 'solidusio/solidus', branch: solidus_branch
end

# Needed to help Bundler figure out how to resolve dependencies,
# otherwise it takes forever to resolve them.
# See https://github.com/bundler/bundler/issues/6677
gem 'rails', '>0.a'

# Provides basic authentication functionality for testing parts of your engine
gem 'solidus_auth_devise'

case ENV.fetch('DB', nil)
when 'mysql'
  gem 'mysql2'
when 'postgresql'
  gem 'pg'
else
  gem 'sqlite3', '~> 1.4'
end

if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3')
  # Fix for Rails 7+ / Ruby 3+, see https://stackoverflow.com/a/72474475
  gem 'net-imap', require: false
  gem 'net-pop', require: false
  gem 'net-smtp', require: false
end

gemspec

# Use a local Gemfile to include development dependencies that might not be
# relevant for the project or for other contributors, e.g. pry-byebug.
#
# We use `send` instead of calling `eval_gemfile` to work around an issue with
# how Dependabot parses projects: https://github.com/dependabot/dependabot-core/issues/1658.
send(:eval_gemfile, 'Gemfile-local') if File.exist? 'Gemfile-local'
