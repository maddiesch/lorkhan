module Lorkhan
  class Request
    attr_reader :path, :headers, :body

    def initialize(notification)
      @path    = "/3/device/#{notification.token}"
      @body    = notification.body
      @headers = build_headers(notification)
    end

    def validate!
      raise Errors::MissingTopicError if headers['apns-topic'].nil?
    end

    private

    def build_headers(notif)
      {}.tap do |head|
        head['apns-id']          = notif.apns_id if notif.apns_id
        head['apns-expiration']  = notif.expiration.to_s if notif.expiration
        head['apns-priority']    = notif.priority.to_s if notif.priority
        head['apns-topic']       = notif.topic if notif.topic
        head['apns-collapse-id'] = notif.collapse_id if notif.collapse_id
        head['apns-push-type']   = notif.push_type
      end
    end
  end
end
