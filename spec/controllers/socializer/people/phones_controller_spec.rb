# frozen_string_literal: true

require "spec_helper"

module Socializer
  RSpec.describe People::PhonesController, type: :controller do
    routes { Socializer::Engine.routes }

    # Create a user and phone
    let(:user) { create(:person) }

    let(:valid_params) do
      { person_id: user,
        person_phone: { category: :home, label: 1, number: "1234567890" } }
    end

    let(:invalid_params) do
      { person_id: user,
        person_phone: { category: :home, label: nil, number: "" } }
    end

    let(:phone) do
      user.phones.create!(valid_params[:person_phone])
    end

    let(:update_params) do
      { id: phone,
        person_id: user,
        person_phone: { number: "6666666666" } }
    end

    context "when not logged in" do
      describe "GET #new" do
        it "requires login" do
          get :new, params: { person_id: user }
          expect(response).to redirect_to root_path
        end
      end

      describe "POST #create" do
        it "requires login" do
          post :create, params: valid_params
          expect(response).to redirect_to root_path
        end
      end

      describe "GET #edit" do
        it "requires login" do
          get :edit, params: { id: phone, person_id: user }
          expect(response).to redirect_to root_path
        end
      end

      describe "PATCH #update" do
        it "requires login" do
          patch :update, params: update_params
          expect(response).to redirect_to root_path
        end
      end

      describe "DELETE #destroy" do
        it "requires login" do
          delete :destroy, params: { id: phone, person_id: user }
          expect(response).to redirect_to root_path
        end
      end
    end

    context "when logged in" do
      # Setting the current user
      before { cookies.signed[:user_id] = user.guid }

      specify { is_expected.to use_before_action(:authenticate_user) }

      describe "GET #new" do
        before do
          get :new, params: { person_id: user }
        end

        specify { expect(response).to have_http_status(:ok) }

        it "renders the :new template" do
          expect(response).to render_template :new
        end
      end

      describe "POST #create" do
        context "with valid attributes" do
          it "saves the new phone in the database" do
            expect { post :create, params: valid_params }
              .to change(Person::Phone, :count).by(1)
          end

          describe "it redirects to people#show" do
            before do
              post :create, params: valid_params
            end

            specify { expect(response).to redirect_to user }
            specify { expect(response).to have_http_status(:found) }
          end
        end

        context "with invalid attributes" do
          it "does not save the new address in the database" do
            expect { post :create, params: invalid_params }
              .not_to change(Person::Phone, :count)
          end

          specify { expect(response).to have_http_status(:ok) }

          it "re-renders the :new template" do
            post :create, params: invalid_params
            expect(response).to render_template :new
          end
        end
      end

      describe "GET #edit" do
        before do
          get :edit, params: { id: phone, person_id: user }
        end

        specify { expect(response).to have_http_status(:ok) }

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end
      end

      describe "PATCH #update" do
        context "with valid attributes" do
          before do
            patch :update, params: update_params
          end

          specify { expect(response).to have_http_status(:found) }

          it "redirects to people#show" do
            expect(response).to redirect_to user
          end

          it "changes the attributes" do
            phone.reload
            expect(phone.number).to eq("6666666666")
          end
        end

        context "with invalid attributes" do
          let(:update_params) do
            { id: phone,
              person_id: user,
              person_phone: { number: "" } }
          end

          before do
            patch :update, params: update_params
          end

          specify { expect(response).to have_http_status(:ok) }

          it "does not change the attributes" do
            phone.reload
            expect(phone.number).not_to eq("")
          end

          it "renders the :edit template" do
            expect(response).to render_template :edit
          end
        end
      end

      describe "DELETE #destroy" do
        it "deletes the phone" do
          phone
          expect { delete :destroy, params: { id: phone, person_id: user } }
            .to change(Person::Phone, :count).by(-1)
        end

        describe "it redirects to people#show" do
          before do
            delete :destroy, params: { id: phone, person_id: user }
          end

          specify { expect(response).to redirect_to user }
          specify { expect(response).to have_http_status(:found) }
        end
      end
    end
  end
end
