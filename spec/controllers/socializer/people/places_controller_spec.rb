# frozen_string_literal: true

require "spec_helper"

module Socializer
  RSpec.describe People::PlacesController, type: :controller do
    routes { Socializer::Engine.routes }

    # Create a user nad place
    let(:user) { create(:person) }

    let(:valid_attributes) do
      { person_id: user,
        person_place: { city_name: "name" } }
    end

    let(:place) do
      user.places.create!(valid_attributes[:person_place])
    end

    let(:update_attributes) do
      { id: place,
        person_id: user,
        person_place: { city_name: "updated content" } }
    end

    describe "when not logged in" do
      describe "GET #new" do
        it "requires login" do
          get :new, params: { person_id: user }
          expect(response).to redirect_to root_path
        end
      end

      describe "POST #create" do
        it "requires login" do
          post :create, params: valid_attributes
          expect(response).to redirect_to root_path
        end
      end

      describe "GET #edit" do
        it "requires login" do
          get :edit, params: { id: place, person_id: user }
          expect(response).to redirect_to root_path
        end
      end

      describe "PATCH #update" do
        it "requires login" do
          patch :update, params: update_attributes
          expect(response).to redirect_to root_path
        end
      end

      describe "DELETE #destroy" do
        it "requires login" do
          delete :destroy, params: { id: place, person_id: user }
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "when logged in" do
      # Setting the current user
      before { cookies.signed[:user_id] = user.guid }

      it { should use_before_action(:authenticate_user) }

      describe "GET #new" do
        before do
          get :new, params: { person_id: user }
        end

        it "assigns a new Person::Place to @place" do
          expect(assigns(:place)).to be_a_new(Person::Place)
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end
      end

      describe "POST #create" do
        context "with valid attributes" do
          it "saves the new place in the database" do
            expect { post :create, params: valid_attributes }
              .to change(Person::Place, :count).by(1)
          end

          it "redirects to people#show" do
            post :create, params: valid_attributes
            expect(response).to redirect_to user
          end
        end

        context "with invalid attributes" do
          it "is a pending example"
        end
      end

      describe "GET #edit" do
        before do
          get :edit, params: { id: place, person_id: user }
        end

        it "assigns the requested place to @place" do
          expect(assigns(:place)).to eq place
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end
      end

      describe "PATCH #update" do
        context "with valid attributes" do
          it "redirects to people#show" do
            patch :update, params: update_attributes
            expect(response).to redirect_to user
          end
        end

        context "with invalid attributes" do
          it "is a pending example"
        end
      end

      describe "DELETE #destroy" do
        it "deletes the place" do
          place
          expect { delete :destroy, params: { id: place, person_id: user } }
            .to change(Person::Place, :count).by(-1)
        end

        it "redirects to people#show" do
          delete :destroy, params: { id: place, person_id: user }
          expect(response).to redirect_to user
        end
      end
    end
  end
end
