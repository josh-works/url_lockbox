require "rails_helper"

RSpec.describe "Logging in existing users" do

  context "a valid user" do
    it "can log back in" do
      user = create(:user)
      visit root_path
      expect(current_path).to eq(authenticate_path)

      within("#sign_in_form") do
        fill_in('user[email]', with: user.email)
        fill_in('user[password]', with: "password")
        click_on('Log in')
      end

      expect(current_path).to eq(links_path)
      within(".flash_notices") do
        expect(page).to have_content("Welcome back, #{user.email}!")
      end
    end

    it "a missing password returns error" do
      user = create(:user)
      visit root_path
      expect(current_path).to eq(authenticate_path)

      within("#sign_in_form") do
        fill_in('user[email]', with: user.email)
        click_on('Log in')
      end

      expect(current_path).to eq(authenticate_path)
      within(".flash_notices") do
        expect(page).to have_content("invalid credentials. please try again")
      end
    end

    it "a mismatched password returns error" do
      user = create(:user)
      visit root_path
      expect(current_path).to eq(authenticate_path)

      within("#sign_in_form") do
        fill_in('user[email]', with: user.email)
        fill_in('user[password]', with: "wrong password")
        click_on('Log in')
      end
      expect(current_path).to eq(authenticate_path)
      within(".flash_notices") do
        expect(page).to have_content("invalid credentials. please try again")
      end
    end
  end

end
