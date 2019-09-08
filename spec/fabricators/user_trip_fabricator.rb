Fabricator(:user_trip) do
  user
  trip
  role 'owner'
end
