Fabricator(:flight) do
  airline { [ "United", "American", "Delta", "Southwest"].sample }
  flight_number { rand_integer(1000) }
  depart_airport 'BNA'
  depart_at { rand_time(start_time: Time.now + 1.week, end_time: Time.now + 3.months) }
  arrive_airport 'LAX'
  arrive_at { rand_time(start_time: Time.now + 3.months, end_time: Time.now + 4.months) }
  amount_in_cents { rand_integer }
  amount_currency 'USD'
  notes { Faker::Lorem.sentence }
end
