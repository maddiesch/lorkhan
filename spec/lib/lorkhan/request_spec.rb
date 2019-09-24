require 'spec_helper'

describe Lorkhan::Request do
  context 'given an alert' do
    let(:notification) { Lorkhan::Notification.new('token') }

    subject { Lorkhan::Request.new(notification) }

    it 'builds path' do
      expect(subject.path).to eq '/3/device/token'
    end

    it 'builds headers' do
      expect(subject.headers).to eq(
        'apns-id' => notification.apns_id,
        'apns-expiration' => '0',
        'apns-priority' => '10',
        'apns-push-type' => 'alert'
      )
    end

    it 'builds body' do
      expect(subject.body).to eq '{"aps":{}}'
    end
  end

  context 'given a content-available' do
    let(:notification) do
      n = Lorkhan::Notification.new('token')
      n.content_available = true
      n
    end

    subject { Lorkhan::Request.new(notification) }

    it 'builds path' do
      expect(subject.path).to eq '/3/device/token'
    end

    it 'builds headers' do
      expect(subject.headers).to eq(
        'apns-id' => notification.apns_id,
        'apns-expiration' => '0',
        'apns-priority' => '5',
        'apns-push-type' => 'background'
      )
    end

    it 'builds body' do
      expect(subject.body).to eq '{"aps":{"content-available":1}}'
    end
  end
end
