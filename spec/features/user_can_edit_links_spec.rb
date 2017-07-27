require "rails_helper"

RSpec.describe "user can edit their links" do

  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "user can edit one of their link titles" do
    link = create(:link)
    @user.links << link

    visit root_path

    within('.links_list') do
      click_on("Edit Link")
    end

    expect(current_path).to eq(edit_link_path(link))

    fill_in('link[title]', with: "Fancy New Title")
    click_on("Update Link")

    expect(current_path).to eq(links_path)

    within('.links_list') do
      expect(page).to have_content("Fancy New Title")
    end
  end

end
