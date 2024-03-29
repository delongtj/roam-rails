class Trip < ApplicationRecord
  include ApiRespondable

  validates :name, presence: true

  has_many :user_trips
  has_many :users, through: :user_trips

  has_many :flights
  has_many :car_rentals
  has_many :accommodations
  has_many :sights

  def self.create_for_user(params, user_id)
    trip = Trip.new(params)

    if trip.save
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
