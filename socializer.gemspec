# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "socializer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "socializer"
  s.version       = Socializer::VERSION
  s.authors       = ["Dominic Goulet"]
  s.email         = ["dominic.goulet@froggedsoft.com"]
  s.description   = "Add social network capabilities to your projects."
  s.summary       = "Make your project social."
  s.homepage      = "http://www.froggedsoft.com"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.required_ruby_version = "~> 2.7.2"

  s.add_dependency("bcrypt",               "~> 3.1.16")
  s.add_dependency("bootstrap-sass",       "~> 3.4.1")
  s.add_dependency("coffee-rails",         "~> 5.0.0")
  s.add_dependency("country_select",       "~> 4.0.0")
  s.add_dependency("draper",               "~> 4.0.1")
  s.add_dependency("dry-initializer",      "~> 3.0.4")
  s.add_dependency("dry-matcher",          "~> 0.8.3")
  s.add_dependency("dry-monads",           "~> 1.3")
  s.add_dependency("dry-validation",       "~> 1.5.6")
  s.add_dependency("elasticsearch-rails",  "~> 7.1.1")
  s.add_dependency("enumerize",            "~> 2.3.1")
  # s.add_dependency("jquery-rails",         "~> 4.3.3")
  # Added "jquery-ui-rails" for drag and drop
  s.add_dependency("jquery-ui-rails",      "~> 6.0.1")
  s.add_dependency("omniauth",             "~> 1.9.1")
  s.add_dependency("omniauth-facebook",    "~> 7.0.0")
  s.add_dependency("omniauth-identity",    "~> 2.0.0")
  s.add_dependency("omniauth-linkedin",    "~> 0.2.0")
  s.add_dependency("omniauth-openid",      "~> 1.0.1")
  s.add_dependency("omniauth-twitter",     "~> 1.4.0")
  s.add_dependency("rails",                "~> 6.0.3")
  s.add_dependency("sass-rails",           "~> 6.0.0")
  s.add_dependency("simple_form",          "~> 5.0.3")
  s.add_dependency("uglifier",             ">= 4.1.19")
  # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
  s.add_dependency("webpacker",            "~> 5.2")

  s.add_development_dependency("bundler",              "~> 2.1.1")
  s.add_development_dependency("rake",                 "~> 13.0.1")
  s.add_development_dependency("sqlite3",              "~> 1.4.2")
  # s.add_development_dependency("rspec-rails",          "~> 3.9.0")
  # s.add_development_dependency("brakeman",             "~> 3.0.5")
  # s.add_development_dependency("cucumber-rails",     "~> 1.4.0")
  # s.add_development_dependency("capybara",             "~> 2.5.0")
  s.add_development_dependency("factory_bot_rails",    "~> 6.1.0")
  s.add_development_dependency("i18n-tasks",           "~> 0.9.31")
  s.add_development_dependency("inch",                 "~> 0.8.0")
  s.add_development_dependency("shoulda-matchers",     "~> 4.4.1")
  # s.add_development_dependency("database_cleaner",     "~> 1.6.0")
  s.add_development_dependency("rails_best_practices", "~> 1.20.0")
  s.add_development_dependency("rubocop",              "~> 0.93.1")
  s.add_development_dependency("rubocop-performance",  "~> 1.8.1")
  s.add_development_dependency("rubocop-rails",        "~> 2.8.1")
  s.add_development_dependency("rubocop-rspec",        "~> 1.43.2")
  s.add_development_dependency("scss_lint",            "~> 0.59.0")
  s.add_development_dependency("solargraph")
end
