require 'rails_helper'

feature 'Admin can sort an index of clients' do

  sign_in_as(:admin)

  scenario "sorting by 'Name'" do
    first  = FactoryGirl.create(:client, name: "Alpha")
    second = FactoryGirl.create(:client, name: "Bravo")

    visit_index

    # Ascending is the default sort order
    expect_clients_to_be_ordered(first, second)

    # Descending
    click_link("Name")
    expect_clients_to_be_ordered(second, first)
  end

private

  def visit_index
    visit(clients_path)
  end

  def expect_clients_to_be_ordered(first, second)
    within(first_row)  { expect(page).to have_content(first.name) }
    within(second_row) { expect(page).to have_content(second.name) }
  end

end
