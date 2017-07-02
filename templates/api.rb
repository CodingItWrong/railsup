def commit(message)
  git add: '.'
  git commit: "-m '#{message}'"
end

def copy_file(file_name, directory = '.')
  inside(directory) do
    puts "CURRENT PATH: #{File.dirname(__FILE__)}"
    file_path = File.expand_path("files/#{file_name}", File.dirname(__FILE__))
    run "cp #{file_path} ."
  end
end

git :init
commit 'Create Rails app'

copy_file '../files/README.md'
run %(sed -i '' "s/\\[APP NAME\\]/#{app_path.titleize}/" README.md)
commit 'Use markdown readme'

copy_file '../files/.rubocop.yml'
commit 'Add rubocop code style config'

run "sed -i '' '/^.*#/ d' Gemfile"
commit 'Remove Gemfile comments'

run "sed -i '' '/byebug/ d' Gemfile"
run "sed -i '' '/coffee-rails/ d' Gemfile"
run "sed -i '' '/jbuilder/ d' Gemfile"
run "sed -i '' '/tzinfo-data/ d' Gemfile"
commit 'Remove unused gems'

gem_group :development do
  gem 'bullet'
  gem 'faker'
end

gem_group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'coderay'
end

commit 'Add development gems'

gem_group :test do
  gem 'factory_girl_rails'
end

commit 'Add factory girl'

gem_group :production do
  gem 'rails_12factor'
  gem 'rack-attack'
end
commit 'Add production gems'

run 'bundle install'
commit 'Bundle gems'

run 'bundle binstubs rspec-core'
run 'rails generate rspec:install'
commit 'Set up RSpec'

copy_file '../files/bin/sample-data', 'bin'
commit 'Add sample data script'

# TODO: clean up gem file
# TODO: Ruby version in gemfile?
# TODO: better error output
