class Accommodation < ApplicationRecord
  acts_as_paranoid

  belongs_to :trip
end
