require "rails_helper"

feature "Admin can update an existing Project" do

  sign_in_as(:admin)
  let!(:project) { FactoryGirl.create(:project, client: client) }
  let(:project_attributes) { FactoryGirl.attributes_for(:project) }
  let!(:client) { FactoryGirl.create(:client) }

  before do
    visit(client_projects_path(client))
    within_row(project.name) do
      click_link("Edit")
    end
  end

  scenario "with valid data" do
    fill_in("Name", with: project_attributes[:name])
    select(client, from: "Client")

    submit_form

    expect(page).to have_flash :notice, "Project was successfully updated."
    project.reload
    expect(project.name).to eq(project_attributes[:name])
    expect(project.client).to eq(client)
  end

  scenario "with invalid data" do
    fill_in("Name", with: "")
    select("", from: "Client")

    submit_form

    expect(page).to have_flash :alert, "Project could not be updated. Please address the errors below."
    expect(page).to have_error_message(:client, "can't be blank")
    expect(page).to have_error_message(:name, "can't be blank")

    project.reload
    expect(project.name).to_not eq(project_attributes[:name])
    expect(project.client).to eq(client)
  end

end
