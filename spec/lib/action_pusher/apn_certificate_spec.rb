require 'action_pusher/apn_certificate'
require 'rails'
require 'pry'

describe ActionPusher::APNCertificate do
  before :each do
    ::Rails.should_receive(:root).and_return('./')
  end

  context 'in production' do
    before :each do
      ::Rails.stub(:env).and_return(
        double('inquirer', production?: true))
    end

    it 'returns a production gateway' do
      apn = ActionPusher::APNCertificate.instance
      apn.gateway_uri.should eq(Houston::APPLE_PRODUCTION_GATEWAY_URI)
    end
  end

  context 'in not production' do
    before :each do
      ::Rails.stub(:env).and_return(
        double('inquirer', production?: false))
    end

    it 'returns a development instance' do
      apn = ActionPusher::APNCertificate.instance
      apn.gateway_uri.should eq(Houston::APPLE_DEVELOPMENT_GATEWAY_URI)
    end
  end
end
