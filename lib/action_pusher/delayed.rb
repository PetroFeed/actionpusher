module Delayed
  class PerformablePusher < PerformableMethod
    def perform
      object.send(method_name, *args)
    end
  end

  module DelayPush
    def delay(options = {})
      proxy = DelayProxy.new(PerformablePusher, self, options)

      # Redefine method_missing on DelayProxy to instantiate our pusher properly
      def proxy.method_missing(method, *args)
        pusher = @target.send(method.to_sym, *args)
        Job.enqueue({:payload_object => @payload_class.new(pusher, :deliver, nil)}.merge(@options))
      end

      proxy
    end
  end
end
