class Accommodation < ApplicationRecord
  include ApiRespondable

  validates :name, :accommodation_type, presence: true

  belongs_to :trip

  def self.types
    ['airbnb', 'hotel', 'campground', 'friend']
  end
end
