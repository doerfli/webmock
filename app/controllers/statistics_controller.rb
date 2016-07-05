class StatisticsController < ApplicationController

  def index
    render :text => 'forbidden', :status => 404 and return unless params[:iknowthesecret].present?

    @stats = {
        'new_mocks_today' => Mock.where( :created_at.gte => Date.today).size,
        'new_mocks_last_7_days' => Mock.where( :created_at.gte => ( Date.today - 7.days )).size,
        'total_mocks' => Mock.all.size,
        'total_mock_requests_today' => MockRequest.where( :created_at.gte => Date.today).size,
        'total_mock_requests_last_7_days' => MockRequest.where( :created_at.gte => ( Date.today - 7.days)).size,
        'total_mock_requests' => MockRequest.all.size,
    }
  end

end