Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :addresses, only: %i[new create]
  resources :artists, only: [] do
    resources :quotations, only: %i[index show new create]
  end
  resources :quotations, only: :destroy
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
