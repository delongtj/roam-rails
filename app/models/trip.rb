class Trip < ApplicationRecord
  acts_as_paranoid

  has_many :user_trips
  has_many :users, through: :user_trips

  has_many :flights
  has_many :car_rentals
  has_many :accommodations
  has_many :points_of_interest

  def self.create_for_user(params, user_id)
    Trip.transaction do
      trip = Trip.create!(params)

      trip.add_user(user_id, :owner)
    end
  end

  def add_user(user_id, role)
    unless user_trips.exists?(user_id: user_id, role: role)
      user_trips.create!(user_id: user_id, role: role)
    end
  end

  def remove_user(user_id)
    user_trips.where(user_id: user_id).destroy_all
  end
end
