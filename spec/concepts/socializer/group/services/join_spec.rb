# frozen_string_literal: true

require "rails_helper"

module Socializer
  class Group
    module Services
      RSpec.describe Join, type: :service do
        let(:person) { build(:person) }

        describe ".call" do
          let(:person) { create(:person) }

          let(:membership_attributes) do
            { member_id: person.guid, group_id: group.id }
          end

          let(:join) do
            Group::Services::Join.new(group: group, person: person)
          end

          let(:membership) { Membership.find_by(membership_attributes) }

          describe "when the group is public" do
            let(:public_group) { create(:group, privacy: :public) }
            let(:group) { public_group }

            before do
              public_group
            end

            it ".public has 1 group" do
              expect(Socializer::Group.public.size).to eq(1)
            end

            it ".joinable has 1 group" do
              expect(Socializer::Group.joinable.size).to eq(1)
            end

            it "is has the right privacy level" do
              expect(public_group.privacy).to be_public
            end

            it "member? is false" do
              expect(public_group).not_to be_member(person)
            end

            context "and a person joins it" do
              before do
                join.call
              end

              it "creates an active membership" do
                expect(membership.active).to be_truthy
              end

              it "member? is true" do
                expect(public_group).to be_member(person)
              end

              # The factory adds a person to the public group by default
              it "has 2 members" do
                expect(public_group.members.size).to eq(2)
              end
            end
          end

          describe "when the group is private" do
            let(:private_group) { create(:group, privacy: :private) }
            let(:group) { private_group }
            let(:error) { Errors::PrivateGroupCannotSelfJoin }

            let(:error_message) do
              I18n.t("private.cannot_self_join",
                     scope: "socializer.errors.messages.group")
            end

            before do
              private_group
            end

            it ".private has 1 group" do
              expect(Socializer::Group.private.size).to eq(1)
            end

            it "is has the right privacy level" do
              expect(private_group.privacy).to be_private
            end

            it "cannot be joined" do
              expect { join.call }.to raise_error(error, error_message)
            end
          end

          describe "when the group is restricted" do
            let(:restricted_group) { create(:group, privacy: :restricted) }
            let(:group) { restricted_group }

            before do
              restricted_group
            end

            it ".restricted has 1 group" do
              expect(Socializer::Group.restricted.size).to eq(1)
            end

            it ".joinable has 1 group" do
              expect(Socializer::Group.joinable.size).to eq(1)
            end

            it "has the right privacy level" do
              expect(restricted_group.privacy).to be_restricted
            end

            context "and a person joins it" do
              before do
                join.call
              end

              it "creates an inactive membership" do
                expect(membership.active).to be_falsey
              end
            end
          end
        end
      end
    end
  end
end
