require "rails_helper"

feature "Admin can update their profile" do

  let(:admin) { FactoryGirl.create(:user, :admin, email: "jk@example.com") }

  background do
    sign_in_as(admin)
    click_admin_my_profile_link(admin)
  end

  scenario "With valid data" do
    fill_in("Given names", with: "JK")
    fill_in("Family name", with: "Gunnink")
    fill_in("Email", with: "valid@example.com")
    fill_in("Current password", with: "password")
    click_button("Update")

    # User should be saved
    expect(page).to have_flash(:notice, "You updated your account successfully, "\
      "but we need to verify your new email address. Please check your email and "\
      "click on the confirm link to finalize confirming your new email address."
    )
    click_admin_my_profile_link(admin.reload)
    # When we update the user, the new email is not changed until confirmed.
    expect(admin.email).to eq("jk@example.com")
    expect(admin.given_names).to eq("JK")
    expect(admin.family_name).to eq("Gunnink")
  end

  scenario "With invalid data" do
    fill_in("Given names", with: "")
    fill_in("Family name", with: "")
    fill_in("Email", with: "")
    click_button("Update")

    expect(page).to have_flash(:alert, "User could not be updated. Please address the errors below.")
    expect(page).to have_error_message(:email, "can't be blank")
    expect(page).to have_error_message(:given_names, "can't be blank")
  end
end
