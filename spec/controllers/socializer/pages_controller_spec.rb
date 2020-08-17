# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe PagesController, type: :controller do
    routes { Socializer::Engine.routes }

    it { is_expected.not_to use_before_action(:authenticate_user) }

    describe "GET #index" do
      before do
        get :index
      end

      context "when not logged in" do
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
      end

      context "when logged in" do
        it "is pending" do
          pending "it has not been implemented yet."
          raise
        end
        # # Create a user
        # let(:user) { create(:person) }

        # # Setting the current user
        # before { cookies.signed[:user_id] = user.guid }
        # before do
        #   allow(controller).to receive(:signed_in?).and_return(true)
        # end

        # it "redirects to activities#index" do
        #   expect(response).to redirect_to activities_path
        # end
      end
    end
  end
end
