require 'spec_helper'

module Socializer
  describe Audience do
    let(:audience) { build(:socializer_audience) }

    it 'has a valid factory' do
      expect(audience).to be_valid
    end

    context 'mass assignment' do
      it { expect(audience).to allow_mass_assignment_of(:activity_id) }
      it { expect(audience).to allow_mass_assignment_of(:privacy_level) }
    end

    context 'relationships' do
      it { expect(audience).to belong_to(:activity) }
      it { expect(audience).to belong_to(:activity_object) }
    end

    context 'validations' do
      it { expect(audience).to validate_presence_of(:privacy_level) }
      # it { expect(audience).to validate_presence_of(:activity_id) }
      # it { expect(create(:socializer_audience)).to validate_uniqueness_of(:activity_id).scoped_to(:activity_object_id) }
    end

    it { expect(enumerize(:privacy_level).in(:public, :circles, :limited).with_default(:public)) }

    context '#object' do
      let(:activitable) { audience.activity_object.activitable }
      it { expect(audience.object).to be_a(activitable.class) }
      it { expect(audience.object).to eq(activitable) }
    end
  end
end
