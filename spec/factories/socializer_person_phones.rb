# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :person_phone, class: Socializer::Person::Phone do
    category { :home }
    number { "6666666666" }
    sequence(:label) { |n| n }
    association :person, factory: :person
  end
end
