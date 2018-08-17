# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe ActivityAudienceList, type: :service do
    describe "when the activity argument is nil" do
      describe ".new should raise an ArgumentError" do
        let(:audience_list) { ActivityAudienceList.new(activity: nil) }

        it { expect { audience_list }.to raise_error(ArgumentError) }
      end

      describe ".call should raise an ArgumentError" do
        let(:audience_list) { ActivityAudienceList.call(activity: nil) }

        it { expect { audience_list }.to raise_error(ArgumentError) }
      end
    end

    describe "when the activity argument is the wrong type" do
      let(:audience_list) { ActivityAudienceList.new(activity: Person.new) }

      it { expect { audience_list }.to raise_error(ArgumentError) }
    end

    describe ".call" do
      context "when no audience" do
        let(:activity) { create(:activity) }

        let(:audience_list) do
          ActivityAudienceList.new(activity: activity).call
        end

        it { expect(audience_list).to be_kind_of(Array) }
        it { expect(audience_list.size).to eq(1) }
        it { expect(audience_list.first).to start_with("name") }
      end

      context "with an audience" do
        let(:person) { create(:person) }

        let(:note_attributes) do
          { content: "Test note",
            object_ids: ["public"],
            activity_verb: "post" }
        end

        let(:note) { person.activity_object.notes.create!(note_attributes) }

        let(:activity) do
          Activity.find_by(activity_object_id: note.activity_object.id)
        end

        context "when public" do
          let(:audience_list) do
            ActivityAudienceList.new(activity: activity).call
          end

          let(:tooltip_public) do
            I18n.t("socializer.activities.audiences.index.tooltip.public")
          end

          it { expect(audience_list.size).to eq(1) }
          it { expect(audience_list.first).to eq(tooltip_public) }
        end

        context "when it is circles" do
          before do
            AddDefaultCircles.call(person: person)
          end

          let(:note_attributes) do
            { content: "Test note",
              object_ids: ["circles"],
              activity_verb: "post" }
          end

          let(:note) { person.activity_object.notes.create!(note_attributes) }

          let(:activity) do
            Activity.find_by(activity_object_id: note.activity_object.id)
          end

          let(:audience_list) do
            ActivityAudienceList.new(activity: activity).call
          end

          it { expect(audience_list.size).to eq(1) }
          it { expect(audience_list.first).to start_with("name") }
        end

        context "when it is limited" do
          before do
            AddDefaultCircles.call(person: person)
          end

          let(:family) do
            Circle.find_by(author_id: person.id, display_name: "Family")
          end

          let(:note_attributes) do
            { content: "Test note",
              object_ids: [family.id],
              activity_verb: "post" }
          end

          let(:note) { person.activity_object.notes.create!(note_attributes) }

          let(:activity) do
            Activity.find_by(activity_object_id: note.activity_object.id)
          end

          let(:audience_list) do
            ActivityAudienceList.new(activity: activity).call
          end

          it { expect(audience_list.size).to eq(1) }
          it { expect(audience_list.first).to start_with("name") }
        end
      end
    end
  end
end
