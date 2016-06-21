require 'rails_helper'

RSpec.feature 'mock history', :type => :feature, :js => true do
  scenario 'User creates a new mock and empty history is shown' do
    visit '/'

    fill_in 'mock_body', with: "{'hello':'world'}"
    click_button 'Create mock now!'

    expect(page).to have_content 'Mock created successfully'

    click_link 'navbar_history'

    expect(page).to have_content 'No requests received yet'
  end

  scenario 'User creates a new mock, sends 1 request and opens history' do
    visit '/'

    fill_in 'mock_body', with: "{'hello':'world'}"
    click_button 'Create mock now!'

    expect(page).to have_content 'Mock created successfully'

    click_link 'mock_link'
    click_link 'navbar_history'

    expect(page).to have_css('.history .content .general', text: 'GET')
    expect(page).to have_css('.history .content .general', text: 'http://127.0.0.1:')
    expect(page).to have_css('.history .content .general', text: '127.0.0.1')
    expect(page).to have_css('.history .content .headers', text: 'PhantomJS')
    expect(page).to have_css('.history .content .body', text: 'Request contained no body data')
  end

  scenario 'User creates a new mock, sends 3 requests and history shows those three requests' do
    visit '/'

    fill_in 'mock_body', with: "{'hello':'world'}"
    click_button 'Create mock now!'

    expect(page).to have_content 'Mock created successfully'

    3.times{ click_link 'mock_link' }
    sleep 2

    click_link 'navbar_history'

    expect(page).to have_css('.history .timeline .request', text: 'GET', count: 3)
  end
end
