source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'

gem 'rails', '~> 5.0.1'
gem 'listen', '~> 3.0.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'foreman'
gem 'ruby-progressbar'
gem 'metamagic'
gem 'validate_url'
gem 'algoliasearch-rails'
gem 'kaminari'
gem 'api-pagination'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'haml-rails', '~> 0.9'
gem 'react-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'font-awesome-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'compass-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-algoliasearch'
  gem 'rails-assets-fetch'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'byebug', platform: :mri
end

group :test do
  gem 'shoulda-matchers'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]