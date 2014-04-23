require 'action_pusher'

class FakeMailer < ActionPusher::Base
  def fake_push(opts = {})
    push(opts)
  end
end

describe ActionPusher::Base do
  before :each do
    @apn_mock = double('apn', push: nil)
    ActionPusher::APNCertificate.stub(:instance).and_return(@apn_mock)
  end

  let(:token) { 'A VALID DEVICE TOKEN' }

  context '#action_name' do
    it 'returns a string of the action called' do
      push = FakeMailer.fake_push
      push.action_name.should eq('fake_push')
    end
  end

  context '#deliver' do
    it 'when called twice only sends a notification once' do
      @apn_mock.should_receive(:push)
      push = FakeMailer.fake_push(tokens: [token], message: 'message')
      push.deliver
      push.deliver
    end

    it 'does not call push on apn if tokens is an empty array' do
      @apn_mock.should_not_receive(:push)

      FakeMailer.fake_push.deliver
    end

    it 'does not call push on apn if message is empty' do
      @apn_mock.should_not_receive(:push)
      FakeMailer.fake_push(tokens: [token], message: '   ').deliver
    end

    it 'calls push on apn if a token and message is present' do
      @apn_mock.should_receive(:push)
      FakeMailer.fake_push(tokens: [token], message: 'message').deliver
    end

    it 'sets alert with value from message' do
      Houston::Notification.any_instance.should_receive(:alert=).with('message')
      FakeMailer.fake_push(tokens: [token], message: 'message').deliver
    end

    it 'defaults to empty hash for custom data' do
      Houston::Notification.any_instance.should_receive(:custom_data=).with({})
      FakeMailer.fake_push(tokens: [token], message: 'message').deliver
    end

    it 'sets custom_data with value from data' do
      Houston::Notification.any_instance.should_receive(:custom_data=).with({ url: 'value' })
      FakeMailer.fake_push(tokens: [token], message: 'message', data: { url: 'value' }).deliver
    end

    it 'defaults to 0 for badge_count' do
      Houston::Notification.any_instance.should_receive(:badge=).with(0)
      FakeMailer.fake_push(tokens: [token], message: 'message').deliver
    end

    it 'sets badge with value from badge_count' do
      Houston::Notification.any_instance.should_receive(:badge=).with(12)
      FakeMailer.fake_push(tokens: [token], message: 'message', badge_count: 12).deliver
    end
  end
end
