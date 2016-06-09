require 'test_helper'

class MockFlowsTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

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

  test 'search mock' do
    mock = create(:mock)

    get '/mocks/search', params: {term: '87fb5727-0892-4962-af25-a157258bd54d'}
    assert_response :redirect
    follow_redirect!
    assert assigns(:mock)

    assert_select 'h3.panel-title small', Regexp.new('87fb5727-0892-4962-af25-a157258bd54d')
    assert_select '.panel-body dd', '200'
    assert_select '.panel-body dd', 'application/json'
  end

  test 'search mock partial' do
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

  test 'search mock partial 2' do
    mock = create(:mock)
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

  test 'search mock partial no unique match' do
    mock = create(:mock)
    mock2 = create(:mock, id: '87fb5727-0892-4962-af25-a157258bd54e')

    get '/mocks/search', params: {term: '87fb5727'}
    assert_redirected_to root_path
  end

  test 'search mock no match' do
    mock = create(:mock)

    get '/mocks/search', params: {term: '87fb5728'}
    assert_redirected_to root_path
  end

end