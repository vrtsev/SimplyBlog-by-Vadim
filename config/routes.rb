Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "omniauth_callbacks" }

  resources :categories
  resources :posts do
    resources :comments
  end
  resources :users, only: :index
  get '/id:user', to: 'profile#index', as: 'profile'
  get '/id:user/posts/:id', to: 'profile#show', as: 'profile_post'
end
