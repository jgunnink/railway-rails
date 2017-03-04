require "rails_helper"

feature "User can view project details" do

  sign_in_as(:member)
  let!(:project) { FactoryGirl.create(:project, stage: 1) }

  before do
    visit(client_project_path(project.client))
  end

  scenario "user can see what stage the project is up to" do
  	expect(page).to have_content("Project stage: 1")
  end

end