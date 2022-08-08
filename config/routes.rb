Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :flights, only: [:index]
  resources :passenger_flights, only: [:update]
  resources :airlines, only:[:show]
end
