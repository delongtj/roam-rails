class Trip < ApplicationRecord
  has_many :users_trips
  has_many :users, through: :users_trips

  has_many :flights
  has_many :car_rentals
  has_many :accommodations
  has_many :points_of_interest
end
