When(/^I open the "([^"]*)" page$/) do |page|
  case page
    when 'index'
      url = '/'
  end

  visit url
end

And(/^enter "([^"]*)" into the "([^"]*)" field$/) do |text,field|
  fill_in field, with: text
end

And(/^click "([^"]*)"$/) do |button_text|
  click_button button_text
end


Then(/^the page contains text "([^"]*)"$/) do |expected_text|
  expect(page).to have_content expected_text
end
