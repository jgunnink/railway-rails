require 'rails_helper'

feature 'Admin can create a new Client' do

  sign_in_as(:admin)

  let(:client_attributes) { FactoryGirl.attributes_for(:client) }


  before do
    visit(clients_path)
    click_link("Add new client")
  end

  scenario 'with valid data' do
    fill_in("Name", with: client_attributes[:name])
    fill_in("Email", with: client_attributes[:email])
    fill_in("Contact name", with: client_attributes[:contact_name])
    fill_in("Contact phone", with: client_attributes[:contact_phone])

    submit_form

    expect(page).to have_content("Client was successfully created.")
    client = Client.order(created_at: :desc).first
    expect(client.name).to eq(client_attributes[:name])
    expect(client.email).to eq(client_attributes[:email])
    expect(client.contact_name).to eq(client_attributes[:contact_name])
    expect(client.contact_phone).to eq(client_attributes[:contact_phone])
  end
end
