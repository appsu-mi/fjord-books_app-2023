Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root to: 'books#index'

  devise_for :users
  resources :users, only: %i[index show]

  resources :books do
    resources :comments, only: :create, module: :books
  end

  resources :reports do
    resources :comments, only: :create, module: :reports
  end

  resources :comments, only: :destroy
end
