require "rails_helper"

feature "User can view an index of Projects" do

  let!(:client) { FactoryGirl.create(:client) }
  sign_in_as(:admin)

  context "where there are existing projects" do
    let!(:project) { FactoryGirl.create(:project, client: client) }
    let!(:tghos) { FactoryGirl.create(:project, client: client, name: "The Green Hills of Stranglethorn") }

    before { visit client_projects_path(client) }

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
      visit(client_projects_path(client))
      expect(page).to have_content "There are no projects."
    end
  end

end
