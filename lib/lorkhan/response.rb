require 'json'

module Lorkhan
  class Response
    attr_reader :headers, :body

    def initialize(raw)
      @headers = raw.headers
      @body    = JSON.parse(raw.body)
    rescue JSON::ParserError
      @body = nil
    end

    def ok?
      status == 200
    end

    def status
      headers[':status'].to_i
    end

    def apns_id
      headers['apns-id']
    end
  end
end
