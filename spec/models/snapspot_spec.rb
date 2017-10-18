require 'rails_helper'

RSpec.describe Snapspot, type: :model do

  context "validations" do

    it "should have name, description, address, latitude, longitude, and user_id columns" do
      should have_db_column(:name).of_type(:string)
      should have_db_column(:description).of_type(:string)
      should have_db_column(:address).of_type(:string)
      should have_db_column(:latitude).of_type(:float)
      should have_db_column(:longitude).of_type(:float)
      should have_db_column(:user_id).of_type(:integer)
    end

    describe "should validate presence of name and description" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:description) }
    end

    let (:snapspot) {build :snapspot}

    it "should have address, latitude and longitude values upon creation" do
      snapspot.save
      expect(snapspot.address).not_to be_empty
      expect(snapspot.latitude).to be_a(Float)
      expect(snapspot.longitude).to be_a(Float)
    end

  end

end
