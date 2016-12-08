require 'rails_helper'

feature 'Admin can delete an existing Project' do

  sign_in_as(:admin)
  let!(:project) { FactoryGirl.create(:project) }

  before do
    visit(client_projects_path(client_id))
  end

  scenario do
    within_row(project.name) do
      click_link("Delete")
    end

    expect(page).to have_flash(:notice, "Project was successfully archived.")
    expect(page).not_to have_content(project.name)
    # Ensure object is deleted
    expect(project.reload).to be_deleted
  end
end
