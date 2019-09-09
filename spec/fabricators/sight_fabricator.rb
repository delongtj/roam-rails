Fabricator(:sight) do
  name { Faker::Lorem.sentence }
  visit_date { Date.tomorrow }
  address { Faker::Address.full_address }
  amount_in_cents { rand_integer }
  amount_currency 'USD'
  notes { Faker::Lorem.sentence }
  order 1
end