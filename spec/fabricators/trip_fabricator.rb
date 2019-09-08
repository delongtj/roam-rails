Fabricator(:trip) do
  name { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  budget_in_cents 10000
  budget_currency 'USD'

  after_create do |trip|
    user = User.first || Fabricate(:user)
    Fabricate(:user_trip, user: user, trip: trip, role: 'owner')
  end
end
