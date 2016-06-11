require "rails_helper"

RSpec.feature "mock creation", :type => :feature do
  scenario "User creates a new mock" do
    visit '/'

    fill_in 'mock_body', with: "{'hello':'world'}"
    click_button 'Create mock now!'

    expect(page).to have_content 'Mock created successfully'
  end
end
