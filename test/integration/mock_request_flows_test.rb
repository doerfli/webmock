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

  test 'mock request stores incoming get request' do
    mock = create(:mock, body: '{ "hello": "world" }', customheaders: [{ 'name': 'X-API-KEY', 'value':'12345678'}] )

    get "/#{mock.id}?a=b"
    assert_response :success
    assert_equal '12345678', response.headers["X-API-KEY"]

    m = Mock.find(mock.id)
    assert_equal 1, m.mock_requests.size
    r1 = m.mock_requests.first
    assert_equal '127.0.0.1', r1.remote_address
    assert_equal 'GET', r1.method
    assert_equal 'application/x-www-form-urlencoded', r1.contenttype
    assert_equal '', r1.body
    assert_equal 0, r1.body_size
    assert_equal "http://www.example.com/#{mock.id}?a=b", r1.url
    assert_equal 'b', r1.query_params['a']
  end

  test 'mock request stores incoming post request' do
    mock = create(:mock, body: '{ "hello": "world" }', customheaders: [{ 'name': 'X-API-KEY', 'value':'12345678'}] )

    post "/#{mock.id}", params: {'hello': 'world'}.to_json, headers: {'CONTENT_TYPE' => 'application/json'}

    assert_response :success
    assert_equal '12345678', response.headers['X-API-KEY']

    m = Mock.find(mock.id)
    assert_equal 1, m.mock_requests.size
    r1 = m.mock_requests.first
    assert_equal '127.0.0.1', r1.remote_address
    assert_equal 'POST', r1.method
    assert_equal 'application/json', r1.contenttype
    assert_equal '{"hello":"world"}', r1.body
    assert_equal 17, r1.body_size
    assert_equal "http://www.example.com/#{mock.id}", r1.url
    assert_nil r1.query_params
  end

  test 'mock request stores multiple incoming requests' do
    mock = create(:mock, body: '{ "hello": "world" }', customheaders: [{ 'name': 'X-API-KEY', 'value':'12345678'}] )

    get "/#{mock.id}?a=b"
    assert_response :success

    get "/#{mock.id}?a=b"
    assert_response :success

    m = Mock.find(mock.id)
    assert_equal 2, m.mock_requests.size

    get "/#{mock.id}?a=b"
    assert_response :success

    m = Mock.find(mock.id)
    assert_equal 3, m.mock_requests.size
  end

  end