# spawnpoint
# A starter template for new Rails projects
#
# https://github.com/impraise/spawnpoint

unless Rails::VERSION::MAJOR >= 4
  raise "spawnpoint was built for rails 4 and up, please update your rails version"
end

# Gemfile & Gems

remove_file "Gemfile"
file "Gemfile", <<-RUBY

source "https://rubygems.org"

gem "rails", "4.2.0"
gem "bcrypt-ruby", "3.1.5"

gem "pg"
gem "oj"
gem "bourbon"
gem "haml-rails"
gem "sass", "~> 3.4.9"
gem "sass-rails"
gem "puma", "~> 2.10"
gem "foreman", require: false

group :development do
  gem "spring"
  gem "quiet_assets"
end

group :development, :test do
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.1.0"
  gem "simplecov", require: false
end

group :development, :doc do
  gem "yard"
  gem "kramdown"
end

group :test do
  gem "shoulda-matchers", "~> 2.7.0", require: false
  gem "timecop"
end

group :production, :staging do
  gem "rack-timeout"
  gem "rails_12factor"
end

RUBY
