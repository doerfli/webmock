require "rails_helper"

RSpec.feature "mock clone", :type => :feature, :js => true do
  scenario "User clones a mock" do
    visit '/'

    fill_in 'mock_body', with: "{'hello':'world'}"
    click_button 'Create mock now!'

    expect(page).to have_content 'Mock created successfully'

    click_link 'Clone'

    expect(page).to have_css('#mock_body', text: "{'hello':'world'}")
    fill_in 'mock_statuscode', with: "201"
    click_button 'Create mock now!'

    expect(page).to have_content 'Mock created successfully'
    expect(page).to have_content '201'
  end
end
