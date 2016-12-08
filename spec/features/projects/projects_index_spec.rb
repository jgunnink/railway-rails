require 'rails_helper'

feature 'Admin can view an index of Projects' do

  sign_in_as(:admin)
  let!(:project) { FactoryGirl.create(:project) }

  before do
    visit(client_projects_path(client_id))
  end

  scenario do
    within("table") do
      expect(page).to have_content(project.name)
    end
  end

end
