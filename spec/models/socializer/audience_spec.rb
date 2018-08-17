# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Audience, type: :model do
    let(:audience) { build(:audience) }

    it "has a valid factory" do
      expect(audience).to be_valid
    end

    context "with relationships" do
      it { is_expected.to belong_to(:activity).inverse_of(:audiences) }
      # FIXME: Test for optional: true
      it { is_expected.to belong_to(:activity_object).inverse_of(:audiences) }
    end

    context "with validations" do
      it { is_expected.to validate_presence_of(:privacy) }
      # it { is_expected.to validate_presence_of(:activity_id) }
      #
      # it do
      #   is_expected
      #   .to validate_uniqueness_of(:activity_id)
      #     .scoped_to(:activity_object_id)
      # end

      # it do
      #   expect(create(:audience))
      #   .to validate_uniqueness_of(:activity_id)
      #     .scoped_to(:activity_object_id)
      # end
    end

    context "with scopes" do
      describe "with_activity_id" do
        let(:sql) { Audience.with_activity_id(id: 1).to_sql }

        it do
          expect(sql)
            .to include('WHERE "socializer_audiences"."activity_id" = 1')
        end
      end

      describe "with_activity_object_id" do
        let(:sql) { Audience.with_activity_object_id(id: 1).to_sql }

        it do
          expect(sql)
            .to include('WHERE "socializer_audiences"."activity_object_id" = 1')
        end
      end
    end

    it do
      is_expected.to enumerize(:privacy)
        .in(:public, :circles, :limited)
        .with_default(:public)
        .with_predicates(true)
        .with_scope(true)
    end

    describe "#object" do
      let(:activitable) { audience.activity_object.activitable }

      it { expect(audience.object).to be_a(activitable.class) }
      it { expect(audience.object).to eq(activitable) }
    end
  end
end
