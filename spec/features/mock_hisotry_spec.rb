require 'rails_helper'

RSpec.feature 'mock history', :type => :feature, :js => true do
  scenario 'User creates a new mock and empty history is shown' do
    visit '/'

    fill_in 'mock_body', with: "{'hello':'world'}"
    click_button 'Create mock now!'

    expect(page).to have_content 'Mock created successfully'

    click_link 'history'

    expect(page).to have_content 'No requests received yet'
  end
end
