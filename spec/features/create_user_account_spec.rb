require "rails_helper"

RSpec.describe "session management" do
  context "a new user visiting root" do

    before :each do
      @email = "example@example.com"
      @pw = "password"
      @pwconf = "password"
    end

    scenario "can create account" do

      visit root_path
      expect(current_path).to eq(authenticate_path)

      fill_in('user[email]', with: @email)
      fill_in('user[password]', with: @pw)
      fill_in('user[password_confirmation]', with: @pwconf)
      click_on('Sign up')

      expect(current_path).to eq("/links")
      within(".flash_notices") do
        expect(page).to have_content("Welcome to URL lockbox, example@example.com!")
      end
    end

    context "new account validation warnings" do
      scenario "leaving email address field blank" do
        visit root_path
        expect(current_path).to eq(authenticate_path)

        fill_in('user[password]', with: @pw)
        fill_in('user[password_confirmation]', with: @pwconf)
        click_on('Sign up')

        expect(current_path).to eq(authenticate_path)
        within(".flash_notices") do
          expect(page).to have_content("email can't be blank")
        end
      end

      scenario "leaving pw conf field blank" do
        visit root_path
        expect(current_path).to eq(authenticate_path)

        fill_in('user[email]', with: @email)
        fill_in('user[password_confirmation]', with: @pw)

        click_on('Sign up')
        save_and_open_page
        expect(current_path).to eq(authenticate_path)
        within(".flash_notices") do
          expect(page).to have_content("password can't be blank")
        end
        # visit root
        # enter email address, pw
        # expect to see "please enter pw confirmation"
        # expect to see "passwords do not match"

      end

      scenario "entering different PW confirmation" do
        visit root_path
        expect(current_path).to eq(authenticate_path)

        fill_in('user[email]', with: @email)
        fill_in('user[password]', with: @pw)

        click_on('Sign up')
        expect(current_path).to eq(authenticate_path)
        within(".flash_notices") do
          expect(page).to have_content("password_confirmation doesn't match Password")
        end
        # visit root
        # enter password, different PW confirmation
        # expect to see "password confirmation does not match"
      end
    end
  end
end
