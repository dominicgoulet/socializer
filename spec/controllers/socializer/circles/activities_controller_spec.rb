# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Circles::ActivitiesController, type: :controller do
    routes { Socializer::Engine.routes }

    # Create a user, circle, and activities
    let(:user) { create(:person) }

    let(:circle) do
      create(:circle, activity_author: user.activity_object)
    end

    let(:activities) do
      Activity.circle_stream(actor_uid: circle.id, viewer_id: user.id).decorate
    end

    context "when not logged in" do
      describe "GET #index" do
        it "requires login" do
          get :index, params: { circle_id: circle }
          expect(response).to redirect_to root_path
        end
      end
    end

    context "when logged in" do
      # Setting the current user
      before { cookies.signed[:user_id] = user.guid }

      it { is_expected.to use_before_action(:authenticate_user) }

      describe "GET #index" do
        before do
          get :index, params: { circle_id: circle }
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "renders the :index template" do
          expect(response).to render_template(:index)
        end
      end
    end
  end
end
