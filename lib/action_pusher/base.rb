require 'active_support'
require 'active_support/core_ext/object/blank'

module ActionPusher
  class Base
    def self.method_missing(method_name, *args)
      if method_defined?(method_name)
        new(method_name, *args).send(method_name, *args)
      else
        super
      end
    end

    # Create apple push notifications to be sent out
    #
    # * *Args*
    #   - +tokens+      -> User's being sent to
    #   - +message+     -> Message sent to tokens
    #   - +data+        -> Custom data passed through the push notification
    #   - +badge_count+ -> Number to place in badge (default is 0)
    def push(opts)
      tokens = [opts[:tokens] || opts[:token] || opts[:to]].flatten
      message = opts[:message] || ''
      data = opts[:data] || {}
      badge_count = opts[:badge_count] || 0

      return self if message.blank?

      @_notifications = Array.new.tap do |notifications|
        tokens.each do |token|
          notifications << Houston::Notification.new(device: token).tap do |notification|
            notification.alert = message
            notification.badge = badge_count
            notification.custom_data = data
          end
        end
      end

      self
    end

    # Returns the name of the method used to generate the push notification
    def action_name
      @_action_name
    end

    # Send out the push notifications
    def deliver
      return self if @_push_was_called

      @_push_was_called = true

      apn = APNCertificate.instance
      @_notifications.each do |notification|
        apn.push(notification)
      end
    end

    #########
    protected
    #########

    def initialize(method_name=nil, *args)
      @_push_was_called = false
      @_action_name = method_name.to_s
      @_notifications = []
    end
  end
end
