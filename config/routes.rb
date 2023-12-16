Rails.application.routes.draw do
  devise_for :users

  root "contents#index"

  resources :students, only: :index do
    resources :results, only: [:index, :show, :create] do
      resources :subjects, only: [:new, :create, :edit, :update, :destroy]
      resources :comments, only: :create
    end
  end

  resources :questions, only: [:index, :create] do
    resources :messages, only: [:index]
  end
end
