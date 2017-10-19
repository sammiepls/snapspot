require 'rails_helper'

describe "creating a snapspot", :type => :feature do
  let (:user) {build :user}

  before :each do
    user.save
    login(user)
    visit '/snapspots/new'
  end

  it "displays snapspot form creation and map" do
    expect(page).to have_css("form#new_snapspot")
    expect(page).to have_css("div#map-new")
  end

  context "with valid params" do
    it "flashes a success message and renders newly created snapspot page" do
      within ("#new_snapspot") do
        fill_in('snapspot_name', with: "Beachfront")
        fill_in('snapspot_description', with: "A beautiful beach with white sand and blue seas.")
        fill_in('snapspot_latitude', with: "42.4376016")
        fill_in('snapspot_longitude',with: "-83.8562834")
        fill_in('snapspot_tag_list', with: "beach,sand,sea")
        click_on('Create Snapspot')
      end

      expect(page).to have_selector "#flash_success", text: "SnapSpot successfully created!"
      expect(page).to have_css("div.snapspot-user-details h1",text:"Beachfront")
      expect(page).to have_css("div.snapspot-details")
      expect(page).to have_content("A beautiful beach with white sand and blue seas.")
      expect(page).to have_content("42.4376016")
      expect(page).to have_content("-83.8562834")
      expect(page).to have_content("#beach #sand #sea")
      expect(page).to have_css("div#show-map")
    end
  end

end
