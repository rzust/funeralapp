Rails.application.routes.draw do
  devise_for :customers

  resources :reservations

  root "reservations#index"
end
