Fabricator(:car_rental) do
  company { [ "Budget", "Alamo", "Hertz", "Enterprise"].sample }
  reservation_number { SecureRandom.hex(10).upcase }
  pick_up_address { Faker::Address.full_address }
  pick_up_at { rand_time(start_time: Time.now + 1.week, end_time: Time.now + 3.months) }
  drop_off_address { Faker::Address.full_address }
  drop_off_at { rand_time(start_time: Time.now + 3.months, end_time: Time.now + 4.months) }
  amount_in_cents { rand_integer }
  amount_currency 'USD'
  notes { Faker::Lorem.sentence }
end