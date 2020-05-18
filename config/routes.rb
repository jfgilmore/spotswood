Rails.application.routes.draw do
  # User authentication
  devise_for :users
  # User administration
  scope :admin do
    resources :users, path_prefix: :admin
  end

  root to: 'welcome#index'
  resources :listings

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
