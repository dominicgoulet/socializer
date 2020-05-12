# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Activity::Operations::Unlike, type: :operation do
    let(:liking_person) { create(:person) }
    let(:liked_activity_object) { create(:activity_object) }
    let(:like) { Activity::Operations::Like.new(actor: liking_person) }
    let(:unlike) { described_class.new(actor: liking_person) }
    let(:results) { unlike.call(unlike_attributes).success[:activity] }

    let(:unlike_attributes) do
      { activity_object: liked_activity_object }
    end

    context "when unliking a liked object, check return type" do
      before do
        like.call(unlike_attributes)
      end

      it { expect(results.persisted?).to eq(true) }
      it { expect(results.verb.display_name).to eq("unlike") }
      it { expect(results).to be_kind_of(Socializer::Activity) }
    end

    describe "check the like_count and liked_by" do
      before do
        like.call(unlike_attributes)
        unlike.call(unlike_attributes)

        liked_activity_object.reload
      end

      it { expect(liked_activity_object.like_count).to eq(0) }
      it { expect(liked_activity_object.liked_by.size).to eq(0) }
    end

    context "with no like, can't unlike" do
      let(:results) { unlike.call(unlike_attributes).failure }

      before do
        unlike.call(unlike_attributes)

        liked_activity_object.reload
      end

      it { expect(liked_activity_object.like_count).to eq(0) }
      it { expect(liked_activity_object.liked_by.size).to eq(0) }

      it "must be ActiveRecord::Relation" do
        expect(results)
          .to be_kind_of(ActiveRecord::Relation)
      end
    end
  end
end
