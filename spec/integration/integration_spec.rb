require 'spec_helper'

xdescribe 'integration', :env do
  let(:device_token)    { ENV['LORKHAN_TEST_DEVICE_TOKEN'] }
  let(:auth_token_path) { File.expand_path(ENV['LORKHAN_TEST_AUTH_KEY_PATH']) }
  let(:team_id)         { ENV['LORKHAN_TEST_TEAM_ID'] }
  let(:key_id)          { ENV['LORKHAN_TEST_AUTH_KEY_ID'] }
  let(:key)             { File.read(auth_token_path) }
  let(:topic)           { ENV['LORKHAN_TEST_TOPIC'] }

  # Check that the ENV is setup
  context 'sanity' do
    it { expect(device_token).to_not be_nil }
    it { expect(auth_token_path).to_not be_nil }
    it { expect(team_id).to_not be_nil }
    it { expect(key_id).to_not be_nil }
    it { expect(key).to_not be_nil }
    it { expect(topic).to_not be_nil }
    it { expect(File.exist?(auth_token_path)).to eq true }
  end

  context 'sending a notification' do
    let(:token)      { Lorkhan::ProviderToken.new(key_id: key_id, team_id: team_id, secret: key) }
    let(:connection) { Lorkhan::Connection.new(token: token, production: false) }

    it 'sends a notification' do
      pending "This will fail without a valid device token"
      notif = Lorkhan::Notification.new(device_token)
      notif.alert = 'Testing'
      notif.topic = topic

      expect(connection.push(notif)).to be_ok
    end
  end
end
