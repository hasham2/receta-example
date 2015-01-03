require 'spec_helper'

feature "Looking up the recipes", js: true do
  
  before do
    Recipe.create!(name: 'Baked Potato w/ Cheese')
    Recipe.create!(name: 'Fried Salmon')
    Recipe.create!(name: 'Pepperoni Pizza')
  end

  scenario "finding recipes" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
  end
end
