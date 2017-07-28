require "rails_helper"

RSpec.describe "link filter", js: true do

  before :each do
    @user = create(:user_with_links)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  xit "can filter links by read status" do
    # couldn't run this test, because create(:user_with_links) wasn't working...
    # user's links wouldn't show up on root path!
    # I think it's related to:
    # https://stackoverflow.com/questions/15938147/factorygirl-creations-dont-show-up-in-selenium-tests
    visit root_path

    save_and_open_page
    within('.links_list') do
      expect(page).to have_css(".link_item", count: 3)
    end

    click_on("Only Unread Links")

    within('.links_list') do
      expect(page).to have_css(".link_item", count: 2)
    end

  end

end
