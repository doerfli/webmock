When(/^I open the "([^"]*)" page$/) do |page|
  case page
    when 'index'
      url = '/'
  end

  visit url
end

When(/^enter "([^"]*)" into the "([^"]*)" field$/) do |text,field|
  fill_in field, with: text
end

When(/^click "([^"]*)"$/) do |button_text|
  click_button button_text
end


Then(/^the page contains text "([^"]*)"$/) do |expected_text|
  expect(page).to have_content expected_text
end
