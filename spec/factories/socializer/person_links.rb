# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :person_link, class: "Socializer::Person::Link" do
    display_name { "test" }
    url { "http://test.org" }
    association :person, factory: :person
  end
end
