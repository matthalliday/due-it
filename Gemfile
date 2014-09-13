source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '4.1.5'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'sorcery'
gem 'turbolinks'
gem 'active_model_serializers'

group :development do
  gem 'spring'
  gem 'better_errors'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'shoulda-matchers', require: false
  gem 'factory_girl_rails'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end
