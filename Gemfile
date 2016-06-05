source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0' #using Puma as the app server
gem 'jbuilder', '~> 2.0'
gem 'bcrypt', '~> 3.1.7' #use ActiveModel has_secure_password
gem 'rack-cors' #for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'redis'
gem 'jwt'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.0'
  gem 'faker'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '~> 3.0.5'
end
