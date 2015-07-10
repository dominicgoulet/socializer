require "rails_helper"

module Socializer
  RSpec.describe Memberships::ConfirmController, type: :controller do
    routes { Socializer::Engine.routes }

    # Create a user, a group, and a membership
    let(:user) { create(:socializer_person) }

    let(:group) do
      create(:socializer_group, activity_author: user.activity_object)
    end

    let(:membership_attributes) do
      { active: false,
        group: group,
        activity_member: user.activity_object
      }
    end

    let(:membership) do
      create(:socializer_membership, membership_attributes)
    end

    describe "when not logged in" do
      describe "POST #create" do
        it "requires login" do
          post :create, id: membership.id
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "when logged in" do
      # Setting the current user
      before { cookies[:user_id] = user.guid }

      it { should use_before_action(:authenticate_user) }

      describe "POST #create" do
        context "with valid attributes" do
          it "confirm the membership" do
            expect(membership.active).to be false

            post :create, id: membership.id

            expect(membership.reload.active).to eq(true)
            expect(assigns(:membership)).to eq membership
          end

          it "redirects to groups#show" do
            post :create, id: membership.id
            expect(response).to redirect_to membership.group
          end
        end

        context "with invalid attributes" do
          it "is a pending example"
        end
      end
    end
  end
end
