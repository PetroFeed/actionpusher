require 'houston'

module ActionPusher
  class APNCertificate
    def self.instance
      apn.tap do |apn|
        # Load required certificate
        apn.certificate = File.read(
          File.join(::Rails.root, 'config', 'certificates', "push-notification-#{APNCertificate.environment_string}.pem"))
      end
    end

    #######
    private
    #######

    def self.environment_string
      if ::Rails.env.production?
        'prod'
      else
        'dev'
      end
    end

    def self.apn
      # Use the correct APN gateway
      # See: https://github.com/nomad/houston/blob/master/lib/houston/client.rb#L2-L6
      if ::Rails.env.production?
        Houston::Client.production
      else
        Houston::Client.development
      end
    end
  end
end
