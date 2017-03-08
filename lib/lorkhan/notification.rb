require 'json'
require 'securerandom'

module Lorkhan
  class Notification
    attr_reader :token, :apns_id
    attr_accessor :custom_payload, :alert, :badge, :sound, :category, :content_available, :url_args, :mutable_content
    attr_accessor :expiration, :priority, :topic, :collapse_id

    def initialize(token)
      @token      = token
      @apns_id    = SecureRandom.uuid
      @expiration = 0
      @priority   = 10
    end

    def body
      JSON.dump(to_h).force_encoding(Encoding::BINARY)
    end

    def to_h
      {}.tap do |root|
        root[:aps] = {}.tap do |aps|
          if content_available
            aps['content-available'] = 1
          else
            aps[:alert] = alert if alert
            aps[:badge] = badge if badge
            aps[:sound] = sound if sound
          end
          aps[:category] = category if category
          aps['url-args'] = url_args if url_args
          aps['mutable-content'] = mutable_content if mutable_content
        end
        root.merge!(custom_payload) if custom_payload
      end
    end
  end
end
