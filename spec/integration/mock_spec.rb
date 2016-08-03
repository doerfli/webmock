require 'rails_helper'

RSpec.describe 'index page', :type => :request do
  it 'displays correctly' do
    get '/'
    assert_response :success
    assert assigns(:new_mock)

    assert_select '#mock_statuscode[value=?]', '200'
    assert_select '#mock_contenttype option[selected=selected]', 'application/json'
    assert_select '#mock_body', ''
  end

  it 'creates a new mock' do
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

  it 'searches mock' do
    create(:mock)

    get '/mocks/search', params: {term: '87fb5727-0892-4962-af25-a157258bd54d'}
    assert_response :redirect
    follow_redirect!
    assert assigns(:mock)

    assert_select 'h3.panel-title small', Regexp.new('87fb5727-0892-4962-af25-a157258bd54d')
    assert_select '.panel-body dd', '200'
    assert_select '.panel-body dd', 'application/json'
  end

  it 'search mock partial' do
    mock = create(:mock)

    get '/mocks/search', params: {term: '87fb5727'}
    assert_response :redirect
    assert_redirected_to mock_path(mock)
    follow_redirect!
    assert assigns(:mock)

    assert_select 'h3.panel-title small', Regexp.new('87fb5727-0892-4962-af25-a157258bd54d')
    assert_select '.panel-body dd', '200'
    assert_select '.panel-body dd', 'application/json'
  end

  it 'search mock partial 2' do
    create(:mock)
    mock2 = create(:mock, id: '87fb5727-a49c-4390-ae38-c74180831d80')

    get '/mocks/search', params: {term: 'a49c'}
    assert_response :redirect
    assert_redirected_to mock_path(mock2)
    follow_redirect!
    assert assigns(:mock)

    assert_select 'h3.panel-title small', Regexp.new('87fb5727-a49c-4390-ae38-c74180831d80')
    assert_select '.panel-body dd', '200'
    assert_select '.panel-body dd', 'application/json'
  end

  it 'search mock partial no unique match' do
    create(:mock)
    create(:mock, id: '87fb5727-0892-4962-af25-a157258bd54e')

    get '/mocks/search', params: {term: '87fb5727'}
    assert_redirected_to root_path
  end

  it 'search mock no match' do
    create(:mock)

    get '/mocks/search', params: {term: '87fb5728'}
    assert_redirected_to root_path
  end

  it 'json history' do
    mock = create(:mock)

    get "/#{mock.id}"
    assert_response :success

    get "/mocks/#{mock.id}/history.json"
    assert_response :success

    history = JSON.parse(@response.body)
    assert_equal 1, history.size
    f = history.first
    assert_equal '127.0.0.1', f['remote_address']
    assert_equal 'GET', f['method']
    assert_equal 'application/x-www-form-urlencoded', f['contenttype']
    assert_equal '', f['body']
    assert_equal 0, f['body_size']
    assert_equal "http://www.example.com/#{mock.id}", f['url']
    assert_nil f['query_params']
  end

  it 'json history with 50 and more results' do
    mock = create(:mock)

    50.times{
      get "/#{mock.id}"
      assert_response :success
    }

    get "/mocks/#{mock.id}/history.json"
    assert_response :success

    history = JSON.parse(@response.body)
    assert_equal 50, history.size
    f = history.first

    # add one more request
    get "/#{mock.id}"
    assert_response :success

    # get history again
    get "/mocks/#{mock.id}/history.json"
    assert_response :success

    history = JSON.parse(@response.body)
    assert_equal 50, history.size

    # make sure latest object is not the same
    expect(f['_id']).not_to eq(history.first['_id'])
  end
end