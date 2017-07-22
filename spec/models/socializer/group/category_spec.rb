# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Group::Category, type: :model do
    let(:group_category) { build(:group_category) }

    it "has a valid factory" do
      expect(group_category).to be_valid
    end

    context "relationships" do
      it { is_expected.to belong_to(:group) }
    end

    context "validations" do
      it { is_expected.to validate_presence_of(:group) }
      it { is_expected.to validate_presence_of(:display_name) }
    end
  end
end
