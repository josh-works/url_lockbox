require "rails_helper"

RSpec.describe "link filter", js: true do

  before :each do
    @user = create(:user_with_links)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  xit "can filter links by read status" do
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
