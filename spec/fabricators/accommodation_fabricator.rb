Fabricator(:accommodation) do
  name { Faker::Lorem.sentence}
  accommodation_type { Accommodation.types.sample }
  address { Faker::Address.full_address }
  check_in_at { rand_time(start_time: Time.now + 1.week, end_time: Time.now + 3.months) }
  check_out_at { rand_time(start_time: Time.now + 3.months, end_time: Time.now + 4.months) }
  amount_in_cents { rand_integer }
  amount_currency 'USD'
  notes { Faker::Lorem.sentence }
end