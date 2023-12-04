Rails.application.routes.draw do
  devise_for :users

  root "contents#index"

  resources :students, only: :index do
    resources :results, only: [:index, :show, :create]
  end

end
