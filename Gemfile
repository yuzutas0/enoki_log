source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails', '4.0.5'
gem 'bootstrap-sass', '2.3.2.0'
gem "font-awesome-rails", '4.2.0.0'
gem 'sprockets', '2.11.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'

group :development, :test do
  gem 'sqlite3', '1.3.9'
  gem 'rspec-rails', '2.13.1'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
end

gem 'sass-rails', '4.0.2'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.1.2'
gem 'turbolinks', '2.4.0'
gem 'jbuilder', '~> 1.5.3'

group :doc do
  gem 'sdoc', '0.4.1', require: false
end

group :production do
	# Heroku
  # gem 'pg', '0.15.1'
  # gem 'rails_12factor', '0.0.2'
  gem 'mysql2', '0.3.17'
  gem 'therubyracer', platforms: :ruby
  gem 'rb-readline', '0.5.1'
end