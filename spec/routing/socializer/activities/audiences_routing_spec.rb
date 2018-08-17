# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Activities::AudiencesController, type: :routing do
    routes { Socializer::Engine.routes }

    context "with routing" do
      it "routes to #index" do
        expect(get: "/activities/1/audience")
          .to route_to("socializer/activities/audiences#index", id: "1")
      end

      it "does not route to #new" do
        expect(get: "/activities/1/activities/new").not_to be_routable
      end

      it "does not route to #show" do
        expect(get: "/activities/1/activities/1/show").not_to be_routable
      end

      it "does not route to #edit" do
        expect(get: "/activities/1/activities/1/edit").not_to be_routable
      end

      it "does not route to #create" do
        expect(post: "/activities/1/activities").not_to be_routable
      end

      context "when it does not route to #update" do
        it { expect(patch: "/activities/1/activities/1").not_to be_routable }
        it { expect(put: "/activities/1/activities/1").not_to be_routable }
      end

      it "does not route to #destroy" do
        expect(delete: "/activities/1/activities/1").not_to be_routable
      end
    end
  end
end
