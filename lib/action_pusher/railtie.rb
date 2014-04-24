require 'action_pusher'
require 'rails'

module ActionPusher
  class Railtie < Rails::Railtie
    config.after_initialize do
      begin
        require 'delayed_job'
        require 'action_pusher/delayed'

        ActionPusher::Base.extend(Delayed::DelayPush)
      rescue
        # noop
      end
    end
  end
end
