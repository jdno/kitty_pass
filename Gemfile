source 'https://rubygems.org'

# Use fixed version to ensure compatibility
gem 'rails', '4.2.1'

# Authentication is provided by devise
gem 'devise', '~> 3.5.1'
gem 'devise-i18n'
gem 'devise-i18n-views'

# Validate IP addresses
gem 'ipaddress', '~> 0.8.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Normalize CSS
gem 'normalize-rails', '~> 3.0'

# Use the Bourbon family as the CSS library
gem 'bourbon', '~> 4.2'
gem 'neat', '~> 1.7'
gem 'bitters', '~> 1.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Capistrano to deploy the app
gem 'capistrano', '~> 3.4'
gem 'capistrano-bundler', '~> 1.1'
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-rbenv', github: 'capistrano/rbenv'

# Configure the environment with Figaro
gem 'figaro', '~> 1.1'

group :production do
  gem 'mysql2'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Rubocop is used to enforce consistent coding style
  gem 'rubocop'

  # Use RSpec for tests
  gem 'rspec-rails'

  # Use Capybara for feature and view specs
  gem 'capybara'

  # Create dummy objects with FactoryGirl: https://github.com/thoughtbot/factory_girl
  gem 'factory_girl'

  # Use DatabaseCleaner in tests to clean up the database
  gem 'database_cleaner'

  # Use Faker to create dummy data
  gem 'faker'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
