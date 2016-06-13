Rails.application.routes.draw do
  match ':id', to: 'mock_requests#show', constraints: { id: /[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i}, via: [:all], :as => 'mocklink'

  resources :mocks do
    member do
      get 'history'
      get 'raw_body'
    end
    collection do
      get 'search'
    end
  end
  resources :mock_requests do
    member do
      get 'raw_body'
    end
  end

  root 'mocks#index'
end

