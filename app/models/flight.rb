class Flight < ApplicationRecord
  include ApiRespondable

  validates :airline, :flight_number, :depart_airport, :depart_at, :arrive_airport, :arrive_at, presence: true

  belongs_to :trip
end
