Action Pusher
============

ActionPusher is an ActionMailer inspired gem to make sending push notifications from Rails as easy as sending emails.

To use, require the gem inside your `Gemfile`:

```
gem 'actionpusher', require: 'action_pusher'
```

Make sure your `.pem` files are under `config/certificates` with the following format:

* `config/certificates/push-notification-prod.pem`
* `config/certificates/push-notification-dev.pem`

Then you can define a push sender. We define our pushers inside of `app/pushers` like so:

```
# app/pushers/my_pusher.rb

class MyPusher < ActionPusher::Base
  def send_a_push_notification
    push(tokens: ['an', 'array', 'of', 'device', 'tokens'],
      message: 'message being sent',
      data: 'extra data sent with the push notification')
  end
end
```

Your push notifications can then be called like a standard Rails mailer:

```
MyPusher.send_a_push_notification.deliver
```

In the event that you're using `Delayed::Job` for your background processing, you can work with it in the same way that
ActionMailer would:

```
MyPusher.delay.send_a_push_notification
```

## TODO

* Implement [interceptor pattern](https://github.com/rails/rails/blob/980cdd30dc06e7cdf3490062731bb9f14789daec/actionmailer/lib/action_mailer/base.rb#L463)
* YAML based configuration for pem files
* <strike>Get working with DelayedJob: `MyPusher.delay.send_a_push_notification`</strike>

## Copyright

Copyright (c) 2014 PetroFeed. See [LICENSE](https://github.com/PetroFeed/actionpusher/blob/master/LICENSE) for further details.

---

Proudly brought to you by [PetroFeed](http://PetroFeed.com).

![Pedro](https://www.petrofeed.com/img/company/pedro.png)

