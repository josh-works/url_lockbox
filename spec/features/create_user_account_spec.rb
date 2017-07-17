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

      within("#sign_up_form") do
        fill_in('user[email]', with: @email)
        fill_in('user[password]', with: @pw)
        fill_in('user[password_confirmation]', with: @pwconf)
        click_on('Sign up')
      end

      expect(current_path).to eq("/links")
      within(".flash_notices") do
        expect(page).to have_content("Welcome to URL lockbox, example@example.com!")
      end
    end

    context "new account validation warnings" do
      scenario "leaving email address field blank" do
        visit root_path
        expect(current_path).to eq(authenticate_path)

        within("#sign_up_form") do
          fill_in('user[password]', with: @pw)
          fill_in('user[password_confirmation]', with: @pwconf)
          click_on('Sign up')
        end

        expect(current_path).to eq(authenticate_path)
        within(".flash_notices") do
          expect(page).to have_content("email is invalid")
        end
      end

      scenario "invalid email address" do
        visit root_path
        expect(current_path).to eq(authenticate_path)

        within("#sign_up_form") do
          fill_in('user[email]', with: "invalid@invalid_email")
          fill_in('user[password]', with: @pw)
          fill_in('user[password_confirmation]', with: @pwconf)
          click_on('Sign up')
        end

        expect(current_path).to eq(authenticate_path)
        within(".flash_notices") do
          expect(page).to have_content("email is invalid")
        end
      end

      scenario "leaving pw conf field blank" do
        visit root_path
        expect(current_path).to eq(authenticate_path)

        within("#sign_up_form") do
          fill_in('user[email]', with: @email)
          fill_in('user[password_confirmation]', with: @pw)
          click_on('Sign up')
        end

        expect(current_path).to eq(authenticate_path)
        within(".flash_notices") do
          expect(page).to have_content("password can't be blank")
        end
      end

      scenario "entering different PW confirmation" do
        visit root_path
        expect(current_path).to eq(authenticate_path)

        within("#sign_up_form") do
          fill_in('user[email]', with: @email)
          fill_in('user[password]', with: @pw)
          click_on('Sign up')
        end

        expect(current_path).to eq(authenticate_path)
        within(".flash_notices") do
          expect(page).to have_content("password_confirmation doesn't match Password")
        end
      end
    end
  end

  context "returning user visiting root" do
    it "can log back in" do
      user = create(:user)
      visit root_path
      expect(current_path).to eq(authenticate_path)

      within("#sign_in_form") do
        fill_in('user[email]', with: user.email)
        fill_in('user[password]', with: "password")
        click_on('Log in')
      end
      save_and_open_page
      expect(current_path).to eq(links_path)
      within(".flash_notices") do
        expect(page).to have_content("Welcome back, #{user.email}!")
      end





    end
  end
end
