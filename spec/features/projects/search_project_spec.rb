require "rails_helper"

feature "User can search for projects by name" do
  let!(:client) { FactoryGirl.create(:client) }
  let!(:matching_project) { FactoryGirl.create(:project, client: client, name: "Froghurt") }
  let!(:other_project) { FactoryGirl.create(:project, client: client, name: "Apartment Living") }

  signed_in_as(:member) do
    before { visit client_projects_path(client) }

    scenario "where one project name matches the terms" do
      fill_in("Search by name", with: matching_project.name)
      click_button("Search")

      expect(page).to have_content(matching_project.name)
      expect(page).not_to have_content(other_project.name)
    end

    scenario "where no projects match the search terms" do
      fill_in("Search by name", with: "Not a valid name project name")
      click_button("Search")

      expect(page).to have_content("No projects matched your search")
      expect(page).not_to have_content(matching_project.name)
      expect(page).not_to have_content(other_project.name)
    end

    scenario "where all projects match the search terms" do
      fill_in("Search by name", with: "t")
      click_button("Search")

      expect(page).to_not have_content("No projects matched your search")
      expect(page).to have_content(matching_project.name)
      expect(page).to have_content(other_project.name)
    end
  end

end
