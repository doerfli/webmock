Rails.application.routes.draw do
  match ':id', to: 'requests#show', constraints: { id: /[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i}, via: [:all]

  resources :mocks
  resources :requests


  root 'mocks#index'
end

# [0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}