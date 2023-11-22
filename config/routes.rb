Rails.application.routes.draw do
  get '/users/sign_out' => 'users/sessions#destroy'

  devise_for :users, skip: :registrations, controllers: {
    sessions: 'users/sessions',
    # confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get '/users/:id/edit', to: 'users/registrations#edit', as: :edit_user
    patch '/users/:id/edit', to: 'users/registrations#update', as: :update_user
    get '/users/sign_up', to: 'users/registrations#new', as: :sign_up_users
    post '/users/sign_up', to: 'users/registrations#create', as: :create_user
    delete '/users/sign_out', to: 'users/registrations#destroy', as: :destroy_user
  end
  root "books#index"
  resources :books
  resources :users, only: [:index, :show]

end
