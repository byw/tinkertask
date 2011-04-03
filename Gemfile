# Edit this Gemfile to bundle your application's dependencies.
# This preamble is the current preamble for Rails 3 apps; edit as needed.
source 'http://rubygems.org'

gem 'rails', '3.0.5'

gem 'compass'
gem 'bson_ext', :require => false
gem 'mongo_mapper', :git => 'git://github.com/jnunemaker/mongomapper.git'
gem 'haml'
gem 'inherited_resources', '>=1.2.1'
gem 'formtastic'
gem 'exceptional'

group :development do
  #gem 'mongrel'
  #gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'spork', '>=0.9.0.rc4'
  gem 'database_cleaner'
  gem 'capybara'
end

group :production do
  gem 'hassle', :git => "git://github.com/koppen/hassle.git" #fixes compass on heroku
end
