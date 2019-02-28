Rails.application.routes.draw do
  devise_for :customers

  get 'reservations/index'
  get 'reservations/new'
  get 'reservations/create'

  root "reservations#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
