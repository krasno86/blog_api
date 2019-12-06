source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.2.2'
gem 'pg'
gem 'puma', '~> 3.12'
gem 'rack-cors', :require => 'rack/cors'
gem 'devise_token_auth'
gem 'fast_jsonapi'
gem 'rswag', '~> 2.0', '>= 2.0.5'
gem 'carrierwave', '~> 2.0'
gem 'mini_magick', '~> 4.9', '>= 4.9.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'pundit-matchers', '~> 1.6.0'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'json_spec', '~> 1.1', '>= 1.1.5'
  gem "json_matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
