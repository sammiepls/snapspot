require 'rails_helper'

RSpec.describe Snapspot, type: :model do

  describe "validations" do

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

    it "should have three tags" do
      snapspot.save
      expect(snapspot.tag_list.count).to eq(3)
    end

  end

  describe "associations" do

    it { should belong_to(:user) }
    it { should have_many(:likes).dependent(:destroy) }

  end

  describe "search" do
    let (:user) {build :user}
    let (:snapspot) {build:snapspot}

    # happy path
    context "when there is a relevant search result" do
      it "should return a result" do
        user.save
        snapspot.save
        expect(Snapspot.search("lake").first).to eq(snapspot)
      end
    end

    # unhappy path
    context "when there is no relevant serach result" do
      it "should return nil" do
        user.save
        expect(Snapspot.search("lake").first).to be_nil
      end
    end
  end

end
