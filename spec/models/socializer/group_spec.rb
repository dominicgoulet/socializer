# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Group, type: :model do
    let(:group) { build(:group) }

    it "has a valid factory" do
      expect(group).to be_valid
    end

    context "with relationships" do
      it do
        is_expected
          .to belong_to(:activity_author)
          .class_name("ActivityObject")
          .with_foreign_key("author_id")
          .inverse_of(:groups)
      end

      it do
        is_expected
          .to have_one(:author)
          .through(:activity_author)
          .source(:activitable)
      end

      it { is_expected.to have_many(:links) }
      it { is_expected.to have_many(:categories) }
      it { is_expected.to have_many(:memberships).inverse_of(:group) }

      it do
        is_expected
          .to have_many(:activity_members)
          .through(:memberships)
          .conditions(socializer_memberships: { active: true })
      end

      it do
        is_expected
          .to have_many(:members)
          .through(:activity_members)
          .source(:activitable)
      end
    end

    context "with validations" do
      it { is_expected.to validate_presence_of(:activity_author) }
      it { is_expected.to validate_presence_of(:display_name) }
      it { is_expected.to validate_presence_of(:privacy) }
      it "check uniqueness of display_name" do
        create(:group)
        is_expected
          .to validate_uniqueness_of(:display_name)
          .scoped_to(:author_id)
          .case_insensitive
      end
    end

    context "with scopes" do
      describe "with_display_name" do
        let(:sql) { Group.with_display_name(name: "Group").to_sql }

        let(:expected) do
          %q(WHERE "socializer_groups"."display_name" = 'Group')
        end

        it do
          expect(sql).to include(expected)
        end
      end
    end

    it do
      is_expected
        .to enumerize(:privacy)
        .in(:public, :restricted, :private).with_default(:public)
        .with_predicates(true)
        .with_scope(true)
    end

    it { is_expected.to respond_to(:author) }
    it { is_expected.to respond_to(:members) }

    context "when having no member" do
      let(:group_without_members) do
        create(:group, privacy: :private)
      end

      before do
        # the author is added as a member, so remove it first
        group_without_members.memberships.first.destroy
      end

      it "can be deleted" do
        expect(group_without_members.destroy.destroyed?).to be true
      end
    end

    context "when having at least one member" do
      let(:group_with_members) do
        create(:group, privacy: :private)
      end

      describe "it cannot be deleted" do
        before do
          group_with_members.destroy
        end

        it { expect(group_with_members.destroyed?).to be false }
        it { expect(group_with_members.errors.present?).to be true }
        it { expect(group_with_members.memberships.count).to eq(1) }
      end
    end
  end
end
