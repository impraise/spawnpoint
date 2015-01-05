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
gem "flutie"
gem "haml-rails"
gem "sass", "~> 3.4.9"
gem "sass-rails"
gem "puma", "~> 2.10"
gem "foreman", require: false
gem "jquery-rails"

group :development do
  gem "spring"
  gem "quiet_assets"
end

group :development, :test do
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.1.0"
  gem "simplecov", require: false
  gem "dotenv-rails"
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


# Rspec

run "bundle install"
generate "rspec:install"
remove_dir "test"
insert_into_file "spec/rails_helper.rb", "\nrequire 'shoulda/matchers'",
                 after: "require 'rspec/rails'"


prepend_to_file "spec/spec_helper.rb" do
<<-RUBY

# SimpleCov section added by spawnpoint
if ENV["RUN_SIMPLECOV"]
  require "simplecov"
  puts "Running Simplecov"
  SimpleCov.start "rails"
end

RUBY
end

append_to_file ".gitignore", "/coverage\n"

# Default layout

remove_file "app/views/layouts/application.html.erb"
file "app/views/layouts/application.html.haml", <<-HAML
!!! 5
%html
  %head
    %meta{charset: "utf-8"}
    %title= page_title

    = stylesheet_link_tag :application
  %body{class: body_class}
    = yield
    = javascript_include_tag :application
HAML

# Default CSS & JS

remove_file "app/assets/javascripts/application.js"
file "app/assets/javascripts/application.js", <<-JAVASCRIPT
//= require jquery
//= require jquery_ujs
//= require_tree .

// :)
JAVASCRIPT

remove_file "app/assets/stylesheets/application.css"
file "app/assets/stylesheets/application.css.scss", <<-SASS
@import "bourbon";

// :)
SASS

# Dotenv & configuration files

file ".env.example", <<-SHELL
SECRET_KEY_BASE=#{SecureRandom.hex(32)}
DATABASE_HOST=localhost
DATABASE_POOL_SIZE=5
DATABASE_USERNAME=batman
DATABASE_PASSWORD=hunter2
DATABASE_NAME=coolproject
TEST_DATABASE_NAME=coolproject_test
SHELL
append_to_file ".gitignore", "/.env\n"

remove_file "config/secrets.yml"
file "config/secrets.yml", <<-YAML
# http://guides.rubyonrails.org/4_1_release_notes.html#config-secrets-yml
development: &default
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
test:
  <<: *default
YAML

remove_file "config/database.yml"
file "config/database.yml", <<-YAML
default: &default
  adapter: postgresql
  encoding: utf8
  host: <%= ENV["DATABASE_HOST"] %>
  pool: <%= ENV["DATABASE_POOL_SIZE"] %>
  username: <%= ENV["DATABASE_USERNAME"] %>
  password: <%= ENV["DATABASE_PASSWORD"] %>
  database: <%= ENV["DATABASE_NAME"] %>

development:
  <<: *default

test:
  <<: *default
  database: <%= ENV["TEST_DATABASE_NAME"] %>

production:
  <<: *default
YAML

# Foreman (Procfile)

file "Procfile.dev.example", <<-YAML
web: spring rails server
YAML
append_to_file ".gitignore", "/Procfile.dev\n"

# Next steps message

after_bundle do
  puts <<-WHATNOW

==============================================================================

  Hurrah! Spawnpoint-generated project ready!

  # What next?

  - Take a look at the Gemfile to have an idea what you're working with
  - Copy .env.example to .env and change the environment variables,
    check out https://github.com/bkeepers/dotenv for help.
  - Copy Procfile.dev.example to Procfile.dev and change to your liking
  - Get started with: $ foreman start -f Procfile.dev

  Built at Impraise
  https://github.com/impraise/spawnpoint

==============================================================================

  WHATNOW
end
