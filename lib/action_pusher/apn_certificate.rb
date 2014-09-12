require 'houston'
require 'yaml'

module ActionPusher
  class APNCertificate
    def self.instance
      apn.tap do |apn|
        apn.certificate = apn_certificate
      end
    end

    private

    def self.apn_certificate
      File.read(certificate_path)
    end

    def self.certificate_path
      File.join(::Rails.root, 'config', 'certificates', certificate_name)
    end

    def self.certificate_name
      config[Rails.env]['name']
    end

    def self.config
      YAML.load_file('config/certificates.yml')
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
