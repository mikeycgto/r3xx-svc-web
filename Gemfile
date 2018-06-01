source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'haml-rails'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0.beta2'
gem 'redis', '~> 4.0'
gem 'responders'
#gem 'sass-rails', '~> 5.0'
gem 'sqlite3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'guard'
  gem 'guard-minitest'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
