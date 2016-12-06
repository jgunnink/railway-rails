require 'rails_helper'

feature 'Admin can delete an existing Client' do

  sign_in_as(:admin)
  let!(:client) { FactoryGirl.create(:client) }

  before do
    visit(clients_path)
  end

  scenario do
    within_row(client.name) do
      click_link("Delete")
    end

    expect(page).to have_flash(:notice, "Client was successfully archived.")
    expect(page).not_to have_content(client.name)
    # Ensure object is deleted
    expect(client.reload).to be_deleted
  end
end
