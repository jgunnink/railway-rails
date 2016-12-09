require "rails_helper"

feature "User can delete an existing Project" do
  let!(:client) { FactoryGirl.create(:client) }
  let!(:project) { FactoryGirl.create(:project, client: client) }

  context "when signed in as an admin" do
    sign_in_as(:admin)

    scenario "User can delete project from client view" do
      visit(client_projects_path(client))

      within_row(project.name) do
        click_link("Delete")
      end

      expect(page).to have_flash(:notice, "Project was successfully archived.")
      expect(page).not_to have_content(project.name)
      # Ensure object is deleted
      expect(project.reload).to be_deleted
    end
  end

  context "when signed in as a member" do
    sign_in_as(:member)

    scenario "User cannot delete project from client view" do
      visit(client_projects_path(client))

      within_row(project.name) do
        expect(page).to_not have_link("Delete")
      end
    end
  end
end
