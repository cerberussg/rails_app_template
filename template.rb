# rails new myapp -m template.rb -> within the templates directory
# rails new myapp -m https://raw.github.com/cerberussg/rails_app_template/master/template.rb -> utilizing the github repo
# rails new myapp -> via ~/.railsrc file

gem 'devise'
gem 'dotenv-rails'
gem_group :development, :test do
  gem 'rspec-rails'
end

run 'bundle install'

generate(:scaffold, 'user', 'first_name', 'last_name')

rails_command('generate devise:install')
rails_command('generate devise User')

environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
environment "config.action_mailer.default_url_options = { host: 'https://example.com', port: 3000 }", env: 'production'

file './.env', <<-CODE
  DB_USERNAME=
  DB_PASSWORD=
CODE

insert_into_file './.gitignore', after: "# Ignore uploaded files in development.\n" do <<-RUBY
/.env
RUBY
end

# file 'config/initializer/rubypythmore.rb', <<-CODE
initializer 'rubypythmore.rb', <<-CODE
  # something 1
  # something 2
  # something 3
CODE

if yes?('Create another initializer?')
  init_name = ask('What do you want to call the initializer?')
  init_name << '.rb' unless init_name.index('.rb')
  initializer init_name, <<-CODE
    # something
  CODE
  # y
  # yes
end

route "root  'users#index'"

after_bundle do
  git :init
  git add: '.'
  git commit: %( -m 'Initial commit')
end
