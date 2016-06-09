require 'test_helper'

class MockRequestFlowsTest < ActionDispatch::IntegrationTest

  test 'simple mock request' do
    mock = create(:mock, body: '{ "hello": "world" }')

    get "/#{mock.id}"
    assert_response :success
    assert_equal '{ "hello": "world" }', response.body

    post "/#{mock.id}"
    assert_response :success
    assert_equal '{ "hello": "world" }', response.body

    put "/#{mock.id}"
    assert_response :success
    assert_equal '{ "hello": "world" }', response.body

    patch "/#{mock.id}"
    assert_response :success
    assert_equal '{ "hello": "world" }', response.body
  end

end