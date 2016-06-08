require 'test_helper'

class MockFlowsTest < ActionDispatch::IntegrationTest

  test 'index page' do
    get '/'
    assert_response :success
    assert assigns(:new_mock)

    assert_select '#mock_statuscode[value=?]', '200'
    assert_select '#mock_contenttype option[selected=selected]', 'application/json'
    assert_select '#mock_body', ''
  end

  test 'create mock' do
    post '/mocks', params: {mock: {statuscode: 200, contenttype: 'application/json', body: '{ "some": "value"}'}}
    assert_response :redirect
    follow_redirect!
    assert assigns(:mock)

    regx = "Mock created successfully! You can now send requests to http://[^/]+/#{assigns[:mock][:id]}"
    assert_select '.alert-success', Regexp.new(regx)
    assert_select 'h3.panel-title small', Regexp.new("#{assigns[:mock][:id]}")
    assert_select '.panel-body dd', '200'
    assert_select '.panel-body dd', 'application/json'
  end

end