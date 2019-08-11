class User < ApplicationRecord
  has_secure_password

  validates :email, :password_digest, presence: true

  has_many :users_trips
  has_many :trips, through: :users_trips
end
