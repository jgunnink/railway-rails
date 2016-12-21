require "rails_helper"

feature "User can view an index of Projects" do

  sign_in_as(:admin)

  context "where there are existing clients" do
    let!(:client) { FactoryGirl.create(:client, name: "JK Gunnink") }
    let!(:other_client) { FactoryGirl.create(:client, name: "Someone else") }

    before { visit clients_path }

    scenario "user can access all clients in a table" do
      within "table" do
        expect(page).to have_content(client.name)
      end
    end

    context "user searches for project" do
      scenario "where the user searches for a matching project" do
        fill_in "Search by name", with: "JK Gunnink"
        click_on "Search"

        within "table" do
          expect(page).to have_content(client.name)
          expect(page).to_not have_content(other_client.name)
        end
      end

      scenario "where the user searches for a project which doesn't match" do
        fill_in "Search by name", with: "A new customer"
        click_on "Search"

        expect(page).to have_content "No clients matched your search."
      end
    end
  end

  context "when no clients exist" do
    scenario do
      visit clients_path
      expect(page).to have_content "There are no clients."
    end
  end

end
