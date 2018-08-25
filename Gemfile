source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap_form', github: 'bootstrap-ruby/bootstrap_form'
gem 'connection_pool'
gem 'devise'
gem 'font-awesome-sass', '~> 5.0.13'
gem 'haml-rails'
gem 'jquery-rails'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2'
gem 'redis', '~> 4.0'
gem 'responders'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-clipboard'
end

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
