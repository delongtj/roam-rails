class User < ApplicationRecord
  include ApiRespondable

  has_secure_password

  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
  validate :password_complexity, if: -> { password.present? }

  has_many :user_trips
  has_many :trips, through: :user_trips

  def password_complexity
    if password.length < 8
      errors.add(:password, "must be at least 8 characters long")
    end
  end
end
