require 'rails_helper'

feature 'Admin can create a new Project' do

  sign_in_as(:admin)

  let(:project_attributes) { FactoryGirl.attributes_for(:project) }
  let!(:client) { FactoryGirl.create(:client) }

  before do
    visit(client_projects_path(client_id))
    click_link("Add a project")
  end

  scenario 'with valid data' do
    fill_in("Name", with: project_attributes[:name])
    select(client, from: "Client")

    submit_form

    expect(page).to have_content("Project was successfully created.")
    project = Project.order(created_at: :desc).first
    expect(project.name).to eq(project_attributes[:name])
    expect(project.client).to eq(client)
  end
end
