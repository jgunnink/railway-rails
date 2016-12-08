require 'rails_helper'

feature 'Admin can sort an index of projects' do

  sign_in_as(:admin)

  scenario "sorting by 'Name'" do
    first  = FactoryGirl.create(:project, name: "Alpha")
    second = FactoryGirl.create(:project, name: "Bravo")

    visit_index

    # Ascending
    click_link("Name")
    expect_projects_to_be_ordered(first, second)

    # Descending
    click_link("Name")
    expect_projects_to_be_ordered(second, first)
  end

private

  def visit_index
    visit(client_projects_path(client_id))
  end

  def expect_projects_to_be_ordered(first, second)
    within(first_row)  { expect(page).to have_content(first.name) }
    within(second_row) { expect(page).to have_content(second.name) }
  end

end
