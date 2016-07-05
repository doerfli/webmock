Rails.application.routes.draw do
  match ':id', to: 'mocks#replay', constraints: { id: /[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i}, via: [:all], :as => 'mocklink'

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
  resources :statistics

  match '/instructions', to: 'pages#instructions', via: :get, as: 'instructions'
  match '/faq', to: 'pages#faq', via: :get, as: 'faq'

  root 'mocks#index'
end

