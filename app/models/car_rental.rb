class CarRental < ApplicationRecord
  include ApiRespondable

  validates :company, presence: true

  belongs_to :trip
end
