Fabricator(:user) do
  email { Faker::Internet.email }
  password { SecureRandom.hex(32) }
end