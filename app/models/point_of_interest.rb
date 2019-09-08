class PointOfInterest < ApplicationRecord
  self.table_name = "points_of_interest"

  include ApiRespondable

  belongs_to :trip
end
