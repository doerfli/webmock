Rails.application.routes.draw do
  resources :mocks

  root 'mocks#index'
end
