# see http://iamvery.com/2015/02/17/rails-new-for-you.html
def commit(message)
  git add: "."
  git commit: "-m '#{message}'"
end

def download_file(url, directory = ".")
  inside(directory) do
    run "curl --location --remote-name #{url}"
  end
end

git :init
commit "Create Rails app"

run "rm README.rdoc"
download_file "https://raw.githubusercontent.com/CodingItWrong/rails-template/master/files/README.md"
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
  gem "faker"
end

commit "Add Faker for sample data"

gem_group :development, :test do
  gem "dotenv"
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

run "bundle install"
commit "Bundle gems"

run "bundle binstubs rspec-core"
run "rails generate rspec:install"
commit "Set up RSpec"

# TODO clean up gem file
# TODO Ruby version in gemfile?
# TODO better error output
