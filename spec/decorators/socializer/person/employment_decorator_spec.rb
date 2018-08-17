# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Person::EmploymentDecorator, type: :decorator do
    let(:employment) { create(:person_employment) }
    let(:decorated_employment) { Person::EmploymentDecorator.new(employment) }

    describe "ended_on" do
      context "when nil" do
        it { expect(decorated_employment.ended_on).to eq(nil) }
      end

      context "when it is a date" do
        let(:date) { Date.new(2015, 12, 3) }
        let(:employment) { create(:person_employment, ended_on: date) }
        let(:ended_on) { date.to_s(:long_ordinal) }

        it { expect(decorated_employment.ended_on).to eq(ended_on) }
      end
    end

    describe "formatted_employment" do
      context "with no job_title or job_description" do
        let(:employment_value) do
          "Some Company<br>" \
          "#{decorated_employment.started_on_to_ended_on}"
        end

        it do
          expect(decorated_employment.formatted_employment)
            .to eq(employment_value)
        end
      end

      context "with job_title without job_description" do
        let(:employment) { create(:person_employment, job_title: "My Title") }

        let(:employment_value) do
          "Some Company<br>" \
          "My Title<br>" \
          "#{decorated_employment.started_on_to_ended_on}"
        end

        it do
          expect(decorated_employment.formatted_employment)
            .to eq(employment_value)
        end
      end

      context "with no job_title with job_description" do
        let(:employment) do
          create(:person_employment, job_description: "Description")
        end

        let(:employment_value) do
          "Some Company<br>" \
          "Description<br>" \
          "#{decorated_employment.started_on_to_ended_on}"
        end

        it do
          expect(decorated_employment.formatted_employment)
            .to eq(employment_value)
        end
      end

      context "with job_title and job_description" do
        let(:employment) do
          create(:person_employment, job_title: "My Title",
                                     job_description: "Description")
        end

        let(:employment_value) do
          "Some Company<br>" \
          "My Title<br>" \
          "Description<br>" \
          "#{decorated_employment.started_on_to_ended_on}"
        end

        it do
          expect(decorated_employment.formatted_employment)
            .to eq(employment_value)
        end
      end
    end

    describe "started_on" do
      let(:started_on) { Date.new(2014, 12, 3).to_s(:long_ordinal) }

      it { expect(decorated_employment.started_on).to eq(started_on) }
    end

    describe "started_on_to_ended_on" do
      let(:started_on) { Date.new(2014, 12, 3).to_s(:long_ordinal) }

      context "when ended_on is nil" do
        let(:value) { "#{started_on} - present" }

        it { expect(decorated_employment.started_on_to_ended_on).to eq(value) }
      end

      context "when ended_on is a date" do
        let(:date) { Date.new(2015, 12, 3) }

        let(:employment) do
          create(:person_employment, ended_on: date, current: false)
        end

        let(:ended_on) { date.to_s(:long_ordinal) }
        let(:value) { "#{started_on} - #{ended_on}" }

        it { expect(decorated_employment.started_on_to_ended_on).to eq(value) }
      end
    end
  end
end
