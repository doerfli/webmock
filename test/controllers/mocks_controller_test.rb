require 'test_helper'

class MocksControllerTest < ActionController::TestCase

  test 'should show index page' do
    get :index
    assert_response :success
    assert_select( '#mock_statuscode[value=?]', '200')
    assert_select( '#mock_contenttype[value=?]', 'application/json')
  end

  test 'should create a new mock' do
    post :create, params: {mock: {statuscode: 200, contenttype: 'application/json', body: '{ "some": "value"}'}}
    assert_response 302
  end

end