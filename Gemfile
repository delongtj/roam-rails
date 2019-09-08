source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails'
gem 'puma'

gem 'redis'
gem 'pg'
gem 'bcrypt'

gem 'rack-cors'
gem 'jwt'

gem 'decent_exposure'
gem 'acts_as_paranoid'

group :development, :test do
  gem 'byebug'
  gem 'faker'
  gem 'fabrication'
  gem 'rspec-rails'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'database_cleaner'
end
