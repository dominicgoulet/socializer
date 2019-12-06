# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :group_category, class: "Socializer::Group::Category" do
    display_name { "category" }
    association :group, factory: :group
  end
end
