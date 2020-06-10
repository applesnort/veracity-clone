Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'aboutus', to: 'pages#aboutus'
  resources :products, only: [:index, :show]
  resources :messages, only: [:index, :new, :create] do
    collection do
      get 'by_product'
    end
  end
  namespace :suppliers do
    resources :verifications, only: [:edit, :update]
    resources :certifications, only: [:new, :create, :edit, :update]
    resources :licenses, only: [:new, :create, :destroy]
    resources :offers, only: [:index, :show, :update]
    resources :products, only: [:create, :new, :edit, :update, :destroy]
    get 'dashboard', to: 'dashboard#show'
  end
  resources :suppliers, only: [:show]
  namespace :purchasers do
    resources :offers, only: [:new, :show, :index, :create, :destroy]
    get 'dashboard', to: 'dashboard#show'
  end
end
