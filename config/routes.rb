Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create destroy show] do
      resources :comments, only: %i[index new create destroy]
      resources :likes, only: %i[create]
    end
  end
end
