Rails.application.routes.draw do

  post 'sign-in', to: 'authentication#sign_in'
  post 'sign-up', to: 'authentication#sign_up'
  post 'sign-out', to: 'authentication#sign_out'

  namespace :api do
    namespace :v1 do
      resources :trips do
        resources :accommodations
        resources :car_rentals
        resources :flights
        resources :sights
      end
    end
  end

end
