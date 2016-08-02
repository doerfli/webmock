class StatisticsController < ApplicationController

  def index
    render :text => 'forbidden', :status => 404 and return unless params[:iknowthesecret].present?

    @stats = {
        'new_mocks_today' => Mock.created_today.size,
        'new_mocks_last_7_days' => Mock.created_last_week.size,
        'new_mocks_last_4_weeks' => Mock.created_last_4_weeks.size,
        'total_mocks' => Mock.all.size,
        'total_mock_requests_today' => MockRequest.created_today.size,
        'total_mock_requests_last_7_days' => MockRequest.created_last_week.size,
        'total_mock_requests_last_4_weeks' => MockRequest.created_last_4_weeks.size,
        'total_mock_requests' => MockRequest.all.size,
    }

    @popular_mocks_today = Mock.by_requests_size.created_today.order('mock_requests_count DESC').limit(100)
    @popular_mocks_last_week = Mock.by_requests_size.created_last_week.order('mock_requests_count DESC').limit(100)
  end

end