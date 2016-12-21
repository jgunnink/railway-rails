require "rails_helper"

feature "User can view an index of Projects" do

  sign_in_as(:admin)

  context "where there are existing projects" do
    let!(:client) { FactoryGirl.create(:client) }
    let!(:project) { FactoryGirl.create(:project, client: client) }
    let!(:tghos) { FactoryGirl.create(:project, client: client, name: "The Green Hills of Stranglethorn") }

    before { visit open_client_projects_path }

    scenario "user can access all projects in a table" do
      within "table" do
        expect(page).to have_content(project.name)
      end
    end

    context "user searches for project" do
      scenario "where the user searches for a matching project" do
        fill_in "Search by name", with: "The Green Hills of Stranglethorn"
        click_on "Search"

        within "table" do
          expect(page).to have_content(tghos.name)
          expect(page).to_not have_content(project.name)
        end
      end

      scenario "where the user searches for a project which doesn't match" do
        fill_in "Search by name", with: "Hemet Nessingwary's Expedition"
        click_on "Search"

        expect(page).to have_content "No projects matched your search."
      end
    end
  end

  context "when no projects exist" do
    scenario do
      visit open_client_projects_path
      expect(page).to have_content "There are no projects. You can create one via the client page."
    end
  end

end
