require "rails_helper"

RSpec.describe "user can edit their links" do

  before :each do
    @user = create(:user_with_links)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "user can edit one of their link titles" do

    visit root_path

    within('.links_list') do
      expect(page).to have_css(".link_item", count: 3)
      expect(page).to have_content(@user.links.first.url)
    end

    within('.links_list') do
      click_on("Edit link")
    end

    expect(current_path).to eq(link_edit_path(@user.links.first))

    fill_in('link[title]', with: "Fancy New Title")
    click_on("Update Link")

    expect(current_path).to eq(root_path)

    within('.links_list') do
      expect(page).to have_content("Fancy New Title")
    end

  end

end
