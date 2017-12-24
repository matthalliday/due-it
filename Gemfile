ruby '2.3.1'
source 'https://rubygems.org'

gem 'rails', '5.0.6'
gem 'pg', '~> 0.18'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'clearance'

group :development do
  gem 'spring'
  gem 'better_errors'
end

group :development, :test do
  gem 'dotenv-rails'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'skylight'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end
