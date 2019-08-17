class User < ApplicationRecord
  acts_as_paranoid

  has_secure_password

  validates :email, :password_digest, presence: true

  has_many :user_trips
  has_many :trips, through: :user_trips
end
