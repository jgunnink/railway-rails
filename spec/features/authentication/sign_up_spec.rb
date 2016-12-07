require "rails_helper"

feature "A visitor can sign up" do

  background do
    visit(root_path)
    click_header_option("Sign up")
  end

  scenario "User signs up successfully" do
    fill_in("Given names", with: "JK")
    fill_in("Family name", with: "Gunnink")
    fill_in("Email", with: "email@example.com")
    # The preceding space and asterix is how capybara is able to match the "Password"
    # field without also matching the "Password confirmation" field.
    fill_in("Password", with: "password", exact: true)
    fill_in("Password confirmation", with: "password")

    submit_form

    expect(page).to have_flash :notice, "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    expect(current_path).to eq(root_path)

    # Signing up should create the user as a member
    new_user = User.first
    expect(new_user).to be_present
    expect(new_user).to be_member
    expect(new_user.email).to eq("email@example.com")
    expect(new_user.given_names).to eq("JK")
    expect(new_user.family_name).to eq("Gunnink")
    expect(new_user.confirmed_at).to be_nil
  end

  scenario "User doesn't fill in details" do
    submit_form
    within("form") do
      expect(page).to have_error_message(:given_names, "can't be blank")
      expect(page).to have_error_message(:email, "can't be blank")
      expect(page).to have_error_message(:password, "can't be blank")
    end
  end
end
