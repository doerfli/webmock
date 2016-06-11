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

  test 'mock request with status code and contenttype' do
    mock = create(:mock, body: '{ "hello": "world" }', statuscode: 401, contenttype: "text/xml")

    get "/#{mock.id}"
    assert_response 401
    assert_equal '{ "hello": "world" }', response.body
    assert_equal 'text/xml', response.content_type

    post "/#{mock.id}"
    assert_response 401
    assert_equal '{ "hello": "world" }', response.body
    assert_equal 401, response.status
    assert_equal 'text/xml', response.content_type
  end

  test 'mock request with custom headers' do
    mock = create(:mock, body: '{ "hello": "world" }', customheaders: [{ 'name': 'X-API-KEY', 'value':'12345678'}] )

    get "/#{mock.id}"
    assert_response :success
    assert_equal '12345678', response.headers["X-API-KEY"]
  end

end