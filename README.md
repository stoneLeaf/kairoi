# kairoi README


* Ruby version

* System dependencies

* Configuration

- should set up ENV["SECRET_KEY_BASE"], used by Devise as config.secret_key in prod
  heroku config:set SECRET_KEY_BASE=*****

- should set up SendGrid
  heroku addons:create sendgrid:starter
  create a SendGrid API key then :
  heroku config:set SENDGRID_API_KEY=xxxx_api_key_xxxx

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
