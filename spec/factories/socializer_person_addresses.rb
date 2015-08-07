# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_address, class: Socializer::PersonAddress do
    category :home
    association :person, factory: :person
    line1 "282 Kevin Brook"
    city "Imogeneborough"
    province_or_state "California"
    postal_code_or_zip "58517"
    country "US"
  end
end
