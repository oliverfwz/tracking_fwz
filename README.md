# TrackingFwz

In this gem we store browser history, you can show it in the email send to admin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tracking_fwz', :git => 'https://github.com/oliverfwz/tracking_fwz.git'
```

And then execute:

    $ bundle

    $ rails g tracking:install

    $ rake db:migrate

If you use active admin
		
		$ rails g tracking:admin

## Usage

Add this line to you application_controller.rb

		include TrackingConcern
		before_action :tracking_history

Build method send mail and include a variable 'histories'. Make 'histories' can use in your template mailer
		
		def notify_after_save (contact, email, histories)
			@contact = contact
			@histories = histories
			mail(
				from: "admin@example.com",
				to: email,
				subject: "New contact"
				)
		end

Because in this gem we use cookie so we need call method send mail in controller. And you add more variable cookies[:tracking_history]

		ContactMailer.notify_after_save(@contact, "oliver@futureworkz.com", cookies[:tracking_history]).deliver_now

Finally, add line in you template mailer
		
		= render "trackings/tracking"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/oliverfwz/tracking_fwz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
