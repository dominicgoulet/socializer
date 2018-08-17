# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe ApplicationController, type: :controller do
    controller do
      def index
        render plain: "Hello"
      end
    end

    let(:user) { create(:person) }

    it { is_expected.to use_before_action(:set_locale) }
    it { is_expected.not_to use_before_action(:authenticate_user) }

    context "when not logged in" do
      before do
        get :index
      end

      it "is a pending example"
    end

    context "when logged in" do
      # Setting the current user
      before { cookies.signed[:user_id] = user.guid }

      describe "#set_locale" do
        context "when the language is set on the person" do
          before do
            get :index
          end

          let(:user) { create(:person, :english) }

          it { expect(I18n.locale.to_s).to eq(user.language) }
        end

        context "when the language is set in 'HTTP_ACCEPT_LANGUAGE'" do
          before do
            request.env["HTTP_ACCEPT_LANGUAGE"] = "en"
            get :index
          end

          let(:language) { request.env["HTTP_ACCEPT_LANGUAGE"] }

          it { expect(I18n.locale.to_s).to eq(language) }
        end
      end
    end
  end
end
