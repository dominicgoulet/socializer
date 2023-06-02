# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in socializer.gemspec.
gemspec

gem "sprockets-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :development, :test do
  gem "bundler-audit", "~> 0.9.1"
  gem "byebug"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "pry-rails"
  gem "rails-dummy", "= 0.1.0"
  gem "rspec-rails", "~> 6.0.0"
  gem "sqlite3"
  gem "typeprof"
end

group :development do
  gem "brakeman", "~> 6.0"
  gem "bundler", ">= 1.15.0", "< 3.0"
  gem "coffeelint", "~> 1.16.1"
  gem "factory_bot_rails", "~> 6.2.0"
  gem "i18n-tasks", "~> 1.0.0"
  gem "inch", "~> 0.8.0"
  gem "listen"
  gem "rails_best_practices", "~> 1.23.0"
  gem "rake", "~> 13.0.6"
  gem "rubocop", "~> 1.52.0"
  gem "rubocop-performance", "~> 1.18.0"
  gem "rubocop-rails", "~> 2.19.0"
  gem "rubocop-rake", "~> 0.6.0"
  gem "rubocop-rspec", "~> 2.22.0"
  gem "rubocop-thread_safety", require: false
  gem "scss_lint", "~> 0.60.0"
  gem "shoulda-matchers", "~> 5.3.0"
  gem "solargraph", "~> 0.48.0"
  # gem "solargraph-rails"
  # gem "solargraph-rails", "~> 1.0.0.pre.1"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15", "< 4.0"
  gem "coveralls_reborn", "~> 0.27.0", require: false
  # gem "cucumber-rails", "~> 1.5.0", require: false
  gem "database_cleaner-active_record", "~> 2.0"
  gem "simplecov", "~> 0.22.0", require: false
  gem "simplecov-lcov", require: false
  gem "webdrivers", "~> 5.0"

  # TODO: Update test so rails-controller-testing can be removed
  gem "rails-controller-testing"
  # net-smtp should be removable when a new version of the mikel/mail
  # gem is released
  gem "net-smtp", require: false
end

# gem "draper", github: "drapergem/draper"

gem "bundler-integrity", "~> 1.0"
