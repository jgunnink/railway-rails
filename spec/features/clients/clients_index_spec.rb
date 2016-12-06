require 'rails_helper'

feature 'Admin can view an index of Clients' do

  sign_in_as(:admin)
  let!(:client) { FactoryGirl.create(:client) }

  before do
    visit(clients_path)
  end

  scenario do
    within("table") do
      expect(page).to have_content(client.name)
    end
  end

end
