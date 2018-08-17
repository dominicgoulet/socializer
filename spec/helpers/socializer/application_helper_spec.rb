# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe ApplicationHelper, type: :helper do
    describe "#signin_path" do
      it "returns the signin path for the given provider" do
        expect(helper.signin_path(:facebook)).to eq("/auth/facebook")
      end
    end

    describe "#current_user?" do
      let(:person) { build(:person) }

      context "when false" do
        before do
          allow(helper).to receive(:current_user).and_return(nil)
        end

        it { expect(helper.current_user?(person)).to be false }
      end

      context "when true" do
        before do
          allow(helper).to receive(:current_user).and_return(person)
        end

        it { expect(helper.current_user?(person)).to be true }
      end
    end
  end
end
