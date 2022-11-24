Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resource :addresses, only: %i[new create edit update]
  resources :artists, only: [] do
    resources :quotations, only: %i[index new create]
  end
  resources :quotations, only: %i[show destroy] do
    resources :messages, only: :create
  end
  get '/quotations/:quotation_id/messages', to: 'messages#messages', as: :messages
  get '/messages', to: 'messages#index', as: :messages_index
  get 'profiles/:user_id', to: 'profiles#show', as: :user_profile
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts do
    resource :comments, only: :create
  end
  resource :comments, only: %i[edit update destroy]
end
