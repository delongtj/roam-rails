class UserTrip < ApplicationRecord
  include ApiRespondable

  belongs_to :user
  belongs_to :trip
end
