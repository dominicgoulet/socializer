# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_education, class: Socializer::Person::Education do
    school_name "Hard Knocks"
    major_or_field_of_study "Slacking"
    started_on { Date.new(2012, 12, 3) }
    ended_on nil
    current true
    association :person, factory: :person
  end
end
