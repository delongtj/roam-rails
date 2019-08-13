Rails.application.routes.draw do

  post 'authenticate', to: 'authentication#authenticate'

  namespace :api do
    namespace :v1 do
      resources :accommodations
      resources :car_rentals
      resources :flights
      resources :point_of_interests
      resources :trips
    end
  end

end
