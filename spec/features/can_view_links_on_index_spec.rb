require "rails_helper"

RSpec.describe "viewing user's links" do
  it "should load all user's links" do
    user = create(:user_with_links)
    links = user.links
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('.links_list') do
      expect(page).to have_css(".link_item", count: 3)
      expect(page).to have_content(links.first.url)
    end
  end
end
