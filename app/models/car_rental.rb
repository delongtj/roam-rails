class CarRental < ApplicationRecord
  include ApiRespondable

  belongs_to :trip
end
