source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.8'

gem 'rails', '~> 6.1'
gem 'pg'
gem 'puma'

gem 'sass-rails'
gem 'uglifier'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jbuilder'
gem 'turbolinks'

gem 'http'
gem 'parallel'
gem 'bootsnap', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rails-controller-testing'
  gem 'faker'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "amazing_print"
  # gem "letter_opener"
  gem "foreman"
  
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'yard'
end

group :test do
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'capybara'
end
