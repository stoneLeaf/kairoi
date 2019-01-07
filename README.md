# kairoi

An unfinished time tracking application made with [Rails](https://rubyonrails.org/).

## Configuration

* set up `ENV["SECRET_KEY_BASE"]`, used by [Devise](https://github.com/plataformatec/devise) as `config.secret_key` in production
> `heroku config:set SECRET_KEY_BASE=*****`
* set up [SendGrid](https://sendgrid.com/)
> `heroku addons:create sendgrid:starter`
* create a SendGrid API key then:
> `heroku config:set SENDGRID_API_KEY=xxxx_api_key_xxxx`

## License

This project is under the [MIT license](LICENSE).
