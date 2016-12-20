# see http://iamvery.com/2015/02/17/rails-new-for-you.html

def commit(message)
  git add: "."
  git commit: "-m '#{message}'"
end

def copy_file(file_name, directory = ".")
  inside(directory) do
    puts "CURRENT PATH: #{File.dirname(__FILE__)}"
    file_path = File.expand_path("files/#{file_name}", File.dirname(__FILE__))
    run "cp #{file_path} ."
  end
end

git :init
commit "Create Rails app"

copy_file "README.md"
run %Q{sed -i '' "s/\\[APP NAME\\]/#{app_path.titleize}/" README.md}
commit "Use markdown readme"

run "sed -i '' '/^.*#/ d' Gemfile"
commit "Remove Gemfile comments"

run "sed -i '' '/byebug/ d' Gemfile"
run "sed -i '' '/coffee-rails/ d' Gemfile"
run "sed -i '' '/jbuilder/ d' Gemfile"
run "sed -i '' '/tzinfo-data/ d' Gemfile"
commit "Remove unused gems"

gem_group :development do
  gem "bullet"
  gem "faker"
end

commit "Add development gems"

gem_group :development, :test do
  gem "dotenv-rails"
  gem "pry-rails"
  gem "rspec-rails"
end

gem_group :test do
  gem "capybara"
  gem "factory_girl_rails"
end

commit "Add testing gems"

gem_group :production do
  gem "rails_12factor"
end
commit "Add 12factor gem for running on Heroku"

gem "rack-attack"

commit "Add rack-attack gem for throttling"

run "bundle install"
commit "Bundle gems"

run "bundle binstubs rspec-core"
run "rails generate rspec:install"
commit "Set up RSpec"

gem "slim"

commit "Add slim templates"

copy_file "bin/sample-data", "bin"
commit "Add sample data script"


# TODO clean up gem file
# TODO Ruby version in gemfile?
# TODO better error output
