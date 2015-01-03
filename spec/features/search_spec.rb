require 'spec_helper'

feature "Looking up the recipes", js: true do
  scenario "finding recipes" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
  end
end
