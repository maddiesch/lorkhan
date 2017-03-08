require 'spec_helper'

describe Lorkhan::Request do
  let(:notification) { Lorkhan::Notification.new('token') }

  subject { Lorkhan::Request.new(notification) }

  it 'builds path' do
    expect(subject.path).to eq '/3/device/token'
  end

  it 'builds headers' do
    expect(subject.headers).to eq({
      'apns-id' => notification.apns_id,
      'apns-expiration' => '0',
      'apns-priority'   => '10'
    })
  end

  it 'builds body' do
    expect(subject.body).to eq %q({"aps":{}})
  end
end
