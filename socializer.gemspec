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

  s.required_ruby_version = "~> 2.5.3"

  s.add_dependency("bcrypt",               "~> 3.1.12")
  s.add_dependency("bootstrap-sass",       "~> 3.3.7")
  s.add_dependency("coffee-rails",         "~> 4.2.2")
  s.add_dependency("country_select",       "~> 3.1.1")
  s.add_dependency("draper",               "~> 3.0.1")
  s.add_dependency("elasticsearch-rails",  "~> 6.0.0")
  s.add_dependency("enumerize",            "~> 2.2.2")
  s.add_dependency("jquery-rails",         "~> 4.3.3")
  # Added "jquery-ui-rails" for drag and drop
  s.add_dependency("jquery-ui-rails",      "~> 6.0.1")
  s.add_dependency("omniauth",             "~> 1.8.1")
  s.add_dependency("omniauth-facebook",    "~> 5.0.0")
  s.add_dependency("omniauth-identity",    "~> 1.1.1")
  s.add_dependency("omniauth-linkedin",    "~> 0.2.0")
  s.add_dependency("omniauth-openid",      "~> 1.0.1")
  s.add_dependency("omniauth-twitter",     "~> 1.4.0")
  s.add_dependency("rails",                "~> 5.2.1")
  s.add_dependency("sass-rails",           "~> 5.0.7")
  s.add_dependency("simple_form",          "~> 4.0.1")
  s.add_dependency("uglifier",             ">= 4.1.19")

  s.add_development_dependency("bundler",              "~> 1.17.1")
  s.add_development_dependency("rake",                 "~> 12.3.1")
  s.add_development_dependency("sqlite3",              "~> 1.3.13")
  # s.add_development_dependency("rspec-rails",          "~> 3.8.1")
  # s.add_development_dependency("brakeman",             "~> 3.0.5")
  # s.add_development_dependency("cucumber-rails",     "~> 1.4.0")
  # s.add_development_dependency("capybara",             "~> 2.5.0")
  s.add_development_dependency("factory_bot_rails",    "~> 4.11.1")
  s.add_development_dependency("i18n-tasks",           "~> 0.9.27")
  s.add_development_dependency("inch",                 "~> 0.8.0")
  s.add_development_dependency("shoulda-matchers",     "~> 3.1.2")
  # s.add_development_dependency("database_cleaner",     "~> 1.6.0")
  s.add_development_dependency("rails_best_practices", "~> 1.19.3")
  s.add_development_dependency("rubocop",              "~> 0.59.2")
  s.add_development_dependency("rubocop-rspec",        "~> 1.30.0")
  s.add_development_dependency("scss_lint",            "~> 0.57.1")
end
