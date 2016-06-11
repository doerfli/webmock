source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'

#gem 'mongoid', '~> 6.0'
# TODO switch to stable once 6.0 available from https://github.com/mongodb/mongoid
gem 'mongoid', git: 'https://github.com/mongodb/mongoid.git'

# Use Puma as the app server
gem 'puma', '~> 3.0'
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
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem 'font-awesome-rails', '~> 4.6.0.0'
gem 'select2-rails', '~> 4.0', '>= 4.0.2'
gem 'react-rails', '~> 1.7', '>= 1.7.1'
#gem 'momentjs-rails', '~> 2.10.2'
#gem 'browser', '~> 0.9.1'
#gem 'uri-js-rails', '~> 1.14.1'
#gem 'handlebars_assets', '~>0.23.0'
#gem 'quiet_assets'
gem 'rails-assets-lodash', '~> 4.13.0', source: 'https://rails-assets.org'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'simplecov'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'passenger'
end

