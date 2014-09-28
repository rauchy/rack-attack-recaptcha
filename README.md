# Rack::Attack::Recaptcha

rack-attack-recaptcha allows you to easily respond to requests that get
throttled by [rack-attack](https://github.com/kickstarter/rack-attack) by showing a captcha instead of the "Retry
later" message you get with [rack-attack](https://github.com/kickstarter/rack-attack). This will allow you to keep
your app functional even in the event of an attack from a public
IP, for example, since legit users who share that IP will still be able
to access the app by entering a captcha.

rack-attack-recaptcha works similarly to [recaptch](http://github.com/ambethia/recaptcha). It gives you 2 helper methods
(`recaptcha_tags_if_under_attack` for views and
`verify_recaptcha_if_under_attack` for controllers) which will simply
call `recaptcha_tags` or `verify_recaptcha` (provided by [recaptcha](http://github.com/ambethia/recaptcha)) accordingly when the current
request should be throttled. If the request is not part of
an attack,
`verify_tags_if_under_attack` will display nothing and
`verify_recaptcha_if_under_attack` will simply return `true`.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-attack-recaptcha'

And then execute:

    $ bundle

Tell your app to use the Rack::Attack middleware. For Rails 3+ apps:

    # In config/application.rb
    config.middleware.use Rack::Attack::Recaptcha

To setup Recaptcha throttles, you should specify the throttle's type to
be `:recaptcha` as shown here:

    Rack::Attack.throttle('req/ip', :limit => 5, :period => 1.second, :type => :recaptcha) do |req|
      req.ip
    end

Check out [rack-attack's](https://github.com/kickstarter/rack-attack)'s wiki for more details on setting throttles.
To setup Recaptcha credentials, check out [recaptcha](http://github.com/ambethia/recaptcha)'s wiki.

## Usage

After you've setup your Recaptcha credentials and defined some throttles, add `recaptcha_tags_if_under_attack` to each form you want to protect. Place it where
you want the Recaptcha widget to appear.

Example:

    # app/views/foos/foo.html.erb

    <%= form_for @foo do |f| %>
      # ... additional lines truncated for brevity ...
      <%= recaptcha_tags_if_under_attack %>
      # ... additional lines truncated for brevity ...
    <% end %>

_(If the request is legit, `recaptcha_tags_if_under_attack` will render nothing.)_

Now add `verify_recaptcha_if_under_attack` logic to each form action that you've
protected:

    # app/controllers/foos_controller.rb

    def create
      if verify_recaptcha_if_under_attack && @foo.save
        # ...
      else
        # ...
      end
    end

_(If the request is legit,
`verify_recaptcha_if_under_attack` won't actually check the captcha and
will simply return `true`)_

Note that `recaptcha_tags_if_under_attack` and `verify_recaptcha_if_under_attack`
pass all options to `recaptcha_tags` and `verify_recaptcha` so you can
use all the configuration values that are provided by [recaptcha](http://github.com/ambethia/recaptcha). (See [recaptcha](http://github.com/ambethia/recaptcha)'s documentation for a list of all the configuration options)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
