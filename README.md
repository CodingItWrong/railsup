# Rails Template

Creates a new Rails app pre-configured to preferences:

- Removes Spring, Turbolinks, CoffeeScript, and JBuilder
- Uses Postgres instead of SQLite
- Uses RSpec instead of Minitest
- Uses pry instead of byebug
- Adds:
  - Bullet
  - Capybara with Selenium-Webdriver for JS-enabled system tests
  - Dotenv
  - Factory Bot
  - Rack-Attack
  - Rails 12 Factor

## Usage

Download the repo, then run `bin/railsup NEW-APP-NAME`.

To be able to run `railsup` from anywhere, add the repo's `bin` directory to your `PATH`.

## Thanks

Based on [this blog post](http://iamvery.com/2015/02/17/rails-new-for-you.html) by [iamvery](https://github.com/iamvery).

## License

MIT. See `License.txt` for details.
