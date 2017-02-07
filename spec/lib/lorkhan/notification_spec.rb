require 'spec_helper'

describe Lorkhan::Notification do
  let(:notification) { Lorkhan::Notification.new('token') }

  describe '#to_h' do
    it 'creates a hash with a root aps object' do
      expect(notification.to_h[:aps]).to_not be_nil
    end

    describe 'contains' do
      it 'alert' do
        notification.alert = 'foo'
        expect(notification.to_h[:aps][:alert]).to eq 'foo'
      end

      it 'badge' do
        notification.badge = 2
        expect(notification.to_h[:aps][:badge]).to eq 2
      end

      it 'sound' do
        notification.sound = 'foo'
        expect(notification.to_h[:aps][:sound]).to eq 'foo'
      end

      it 'category' do
        notification.category = 'foo'
        expect(notification.to_h[:aps][:category]).to eq 'foo'
      end

      it 'content-available' do
        notification.content_available = true
        expect(notification.to_h[:aps]['content-available']).to eq true
      end

      it 'url-args' do
        notification.url_args = 'foo'
        expect(notification.to_h[:aps]['url-args']).to eq 'foo'
      end

      it 'mutable-content' do
        notification.mutable_content = 'foo'
        expect(notification.to_h[:aps]['mutable-content']).to eq 'foo'
      end
    end

    it 'merges custom payload' do
      notification.custom_payload = {foo: :bar}
      expect(notification.to_h[:foo]).to eq :bar
    end
  end
end
