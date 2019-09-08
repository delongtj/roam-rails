class Flight < ApiModel
  include ApiRespondable

  belongs_to :trip
end
