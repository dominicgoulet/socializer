# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Groups::OwnershipsController, type: :routing do
    routes { Socializer::Engine.routes }

    context "with routing" do
      it "routes to #index" do
        expect(get: "/groups/ownerships")
          .to route_to("socializer/groups/ownerships#index")
      end

      it "does not route to #new" do
        expect(get: "/groups/ownerships/new").not_to be_routable
      end

      it "does not route to #show" do
        expect(get: "/groups/ownerships/show").not_to be_routable
      end

      it "does not route to #edit" do
        expect(get: "/groups/ownerships/1/edit").not_to be_routable
      end

      it "does not route to #create" do
        expect(post: "/groups/ownerships").not_to be_routable
      end

      context "when it does not route to #update" do
        it { expect(patch: "/groups/ownerships/1").not_to be_routable }
        it { expect(put: "/groups/ownerships/1").not_to be_routable }
      end

      it "does not route to #destroy" do
        expect(delete: "/groups/ownerships/1").not_to be_routable
      end
    end
  end
end
