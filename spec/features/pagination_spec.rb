require 'rails_helper'

describe "paginate the snapspots index page", :type => :feature do
  let (:user) {build :user}

  before :each do
    user.save
    login(user)
    12.times { FactoryGirl.create(:snapspot) }
  end

  it "displays pagination when snapspots are more than 9" do
    visit '/snapspots'
    expect(page).to have_css("div.pagination a", text:"Next")
  end

  it "should correctly mark active page" do
    visit '/snapspots?page=2'
    expect(page).to have_css("div.pagination em.current", text:"2")
  end

  it "should disable the next link if user is on the last page" do
    visit '/snapspots?page=2'
    expect(page).to have_css("span.next_page.disabled", text:"Next →")
  end

end
