class Sight < ApplicationRecord
  include ApiRespondable

  validates :name, :visit_date, :order, presence: true
  belongs_to :trip
end
