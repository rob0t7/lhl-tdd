require 'rails_helper'

RSpec.feature "BreweryManagements", type: :feature do
  scenario "As an Admin I want to see all the breweries in the system" do
    # insert models into DB
    brewery1 = FactoryBot.create(:brewery)
    brewery2 = FactoryBot.create(:brewery)

    # call the index action
    visit root_path

    # assert all the breweries are there
    expect(page).to have_content(brewery1.name)
    expect(page).to have_content(brewery2.name)
  end

  scenario "Add a new brewery" do
    visit root_path
    click_link 'New Brewery'

    fill_in :brewery_name, with: "My New Best Brewery"
    click_button 'Add Brewery'

    expect(page).to have_content "My New Best Brewery"
    expect(page).to have_content "Successfully added new Brewery."
  end

end
