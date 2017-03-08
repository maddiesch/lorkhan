require 'json'

module Lorkhan
  ##
  # A wrapper around the HTTP/2 response from Apple
  ##
  class Response
    attr_reader :headers, :body

    # This class should never be instantiated directly.
    def initialize(raw)
      @headers = raw.headers
      @body    = JSON.parse(raw.body)
    rescue JSON::ParserError
      @body = nil
    end

    ##
    # Convenience method to check if the status is 200
    ##
    def ok?
      status == 200
    end

    ##
    # Get the HTTP status
    ##
    def status
      headers[':status'].to_i
    end

    ##
    # Get the APNS id for the notification
    ##
    def apns_id
      headers['apns-id']
    end
  end
end
