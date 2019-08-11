Rails.application.routes.draw do

  resources :point_of_interests
  resources :accommodations
  resources :car_rentals
  resources :flights
  namespace :api do
    namespace :v1 do
      resources :trips
    end
  end

end
