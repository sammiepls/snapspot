require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do

    it "should have username and email and password_digest" do
      should have_db_column(:username).of_type(:string)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:password_digest).of_type(:string)
    end

    describe "validates presence and uniqueness of username and email" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_uniqueness_of(:username) }
    end

    describe "validates password" do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_presence_of(:password_confirmation) }
      it { is_expected.to validate_length_of(:password).is_at_least(7).is_at_most(20) }
      it { is_expected.to validate_confirmation_of(:password) }
    end
  end

  context "associations" do

    # it { should have_many(:snapspots) }
    # it { should belong_to(:likes) }
    # it { should belong_to(:comments) }

  end
end
