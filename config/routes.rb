Rails.application.routes.draw do
  root to: 'welcome#index'

  # User authentication
  devise_for :users
  # User administration
  scope :admin do
    resources :users, path_prefix: :admin
  end

  resources :interactions
  resources :listings

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
