require 'rails_helper'

feature 'Admin can view an index of Projects' do

  sign_in_as(:admin)
  let!(:client) { FactoryGirl.create(:client) }
  let!(:project) { FactoryGirl.create(:project, client: client) }

  before do
    visit(client_projects_path(client))
  end

  scenario do
    within("table") do
      expect(page).to have_content(project.name)
    end
  end

end
