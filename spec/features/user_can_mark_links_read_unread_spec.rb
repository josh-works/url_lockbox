require "rails_helper"

RSpec.describe "user can mark links as read", js: true do

  before :each do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "user can mark unread link as read" do
    link_title = "cool new link"
    link_url = "https://www.new_link.com"

    visit root_path

    within('#create_new_link') do
      fill_in('link[title]', with: link_title)
      fill_in('link[url]', with: link_url)
      click_on("Save Link")
    end

    within('.link_item') do
      expect(page).to_not have_css('.read')
    end

    within('.link_item .read-status') do
      expect(page).to have_text("false")
    end

    click_on "Mark as Read"

    save_and_open_page
    within('.links_list') do
      expect(page).to have_css('.read')

      within('.read-status') do
        expect(page).to have_text("true")
      end
    end
  end

  xscenario "user can mark read link as unread" do

    visit root_path

    within('.link_item') do
      expect(page).to have_css('.read')
      click_on("Mark Link as Unread")

    end

    within('.link_item') do
      expect(page).to_not have_css('.read')
    end
  end

end
