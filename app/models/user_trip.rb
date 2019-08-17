class UserTrip < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :trip
end
