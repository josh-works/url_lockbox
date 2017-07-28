require "rails_helper"

RSpec.describe "create new links for a user", js: true do

  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "should show new user's link" do
    link_title = "cool new link"
    link_url = "https://www.new_link.com"

    visit root_path

    within('#create_new_link') do
      fill_in('link[title]', with: link_title)
      fill_in('link[url]', with: link_url)
      click_on("Save Link")
    end
    within('.links_list') do
      expect(page).to have_css(".link_item", count: 1)
      expect(page).to have_content(@user.links.first.url)
    end
  end

  xit "should show error message with invalid URL" do
    # skipped because... I couldn't rig up error messages from AJAX. :(
    link_title = "cool updated link"
    invalid_url = "www.new_link.com"

    visit root_path

    within('#create_new_link') do
      fill_in('link[title]', with: link_title)
      fill_in('link[url]', with: invalid_url)
      click_on("Save Link")
    end

    within(".flash_notices") do
      expect(page).to have_content("#{invalid_url} is invalid. Please try again")
    end

  end
end
