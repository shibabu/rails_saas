source 'https://rubygems.org'

# Ruby version
ruby '2.2.2'

# DotEnv to automatically export ENV VARS from the .env file on application boot
gem 'dotenv-rails', :groups => [:development, :test]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Log redirecting to StdOut for Heroku
gem 'rails_12factor', group: :production

# Auth
gem 'devise'
gem 'devise_invitable'

# Asynchronous Devise Mail Send
# gem 'devise-async' # Replaced with ActiveJob, as devise_async is not compatible with new devise versions

# Pretty Print Hashes
gem 'awesome_print'

# Background Jobs with Sidekiq
gem 'sidekiq'

# Puma as Web Server
gem 'puma'

# Bootstrap Sass
gem 'bootstrap-sass'

# Simple Form
gem 'simple_form'

# Payment processing with Stripe
gem 'stripe'

# Webhooks for Stripe Events
gem 'stripe_event'

# Multitenancy using apartment gem
gem 'apartment'

# Apartment support for Sidekiq's tenant-specific jobs
gem 'apartment-sidekiq'

# Add roles to models
gem 'rolify'

# Authorization
gem 'cancancan'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Webhooks tunneling to Localhost
  gem 'ultrahook'
end

