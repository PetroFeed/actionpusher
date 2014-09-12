require 'action_pusher/apn_certificate'
require 'active_support'
require 'rails'
require 'pry'

describe ActionPusher::APNCertificate do
  before :each do
    ::Rails.should_receive(:root).and_return('./')
  end

  context 'in production' do
    before :each do
      inquirer = ActiveSupport::StringInquirer.new('production')
      ::Rails.stub(:env).and_return(inquirer)
    end

    it 'returns a production gateway' do
      apn = ActionPusher::APNCertificate.instance
      apn.gateway_uri.should eq(Houston::APPLE_PRODUCTION_GATEWAY_URI)
    end
  end

  context 'in development' do
    before :each do
      inquirer = ActiveSupport::StringInquirer.new('development')
      ::Rails.stub(:env).and_return(inquirer)
    end

    it 'returns a development instance' do
      apn = ActionPusher::APNCertificate.instance
      apn.gateway_uri.should eq(Houston::APPLE_DEVELOPMENT_GATEWAY_URI)
    end
  end
end
