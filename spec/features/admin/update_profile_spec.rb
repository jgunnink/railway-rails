require 'rails_helper'

feature 'Admin can update their profile' do

  signed_in_as(:admin) do
    before do
      click_admin_my_profile_link(current_user)
    end

    scenario 'With valid data' do
      fill_in("Given names", with: "JK")
      fill_in("Family name", with: "Gunnink")
      fill_in("Email", with: "valid@example.com")
      fill_in("Current password", with: "password")
      click_button("Update")

      # User should be saved
      expect(page).to have_flash(:notice, "You updated your account successfully.")
      click_admin_my_profile_link(current_user.reload)
      expect(current_user.email).to eq("valid@example.com")
      expect(current_user.given_names).to eq("JK")
      expect(current_user.family_name).to eq("Gunnink")
    end

    scenario 'With invalid data' do
      fill_in("Given names", with: "")
      fill_in("Family name", with: "")
      fill_in("Email", with: "")
      click_button("Update")

      expect(page).to have_flash(:alert, "User could not be updated. Please address the errors below.")
      expect(page).to have_error_message(:email, "can't be blank")
      expect(page).to have_error_message(:given_names, "can't be blank")
    end
  end
end
