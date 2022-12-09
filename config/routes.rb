Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :addresses, only: %i[new create edit update]
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

  resources :posts do
    resources :comments, except: :index
    resources :likes, only: :create
  end
  resources :comments, only: %i[edit update destroy]
  resources :likes, only: %i[destroy]
  resources :tags
end
