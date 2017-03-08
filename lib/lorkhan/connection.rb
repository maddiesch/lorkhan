require 'net-http2'
require 'openssl'

module Lorkhan
  APNS_PRODUCTION_HOST  = 'api.push.apple.com'.freeze
  APNS_DEVELOPMENT_HOST = 'api.development.push.apple.com'.freeze
  TOKEN_EXPIRE_TIME_SEC = 3300 # 55 minutes (Apple timeout is 60)

  ##
  # The Connection class manages the HTTP/2 connection to Apple's servers
  #
  # token: (Lorkhan::ProviderToken) Used to authenticate with Apple's servers
  # production: (Boolean) Used to determine which endpoint to establish the connection
  # timeout: (Int) Number of seconds to wait before timing out opening the connection
  ##
  class Connection
    attr_reader :host, :token

    def initialize(token:, production: true, timeout: 30)
      raise ArgumentError, 'Token must be a Lorkhan::ProviderToken' unless token.is_a?(Lorkhan::ProviderToken)

      @host    = production ? APNS_PRODUCTION_HOST : APNS_DEVELOPMENT_HOST
      @timeout = timeout
      @token   = token
      @client  = NetHttp2::Client.new(url, connect_timeout: @connect_timeout)
    end

    ##
    # Closes the connection to apple.
    ##
    def close
      @client.close
    end

    ##
    # Closes the connection and resets the authentication token.
    #
    # This should happen automatically 55 minutes after the original token was generated.
    ##
    def refresh_token
      @auth_token = nil
      close
    end

    ##
    # Deliver a Lorkhan::Notification to Apple's servers.
    #
    # If the connection is not open, this will attempt to establish the connection.
    #
    # notification: (Lorkhan::Notification) The notification to deliver.
    #
    # return: The HTTP response from Apple
    ##
    def push(notification)
      check_token_should_refresh
      request = Request.new(notification)
      request.validate!
      headers = request.headers
      headers['authorization'] = "bearer #{auth_token}"
      raw_response = @client.call(:post, request.path, body: request.body, headers: headers, timeout: 5)
      raise Errors::TimeoutError if raw_response.nil?
      response = Response.new(raw_response)
      handle_http_error(response) unless response.ok?
      response
    end

    private

    def auth_token
      @auth_token ||= begin
        @refresh_token_at = Time.now.to_i + TOKEN_EXPIRE_TIME_SEC
        token.encode
      end
    end

    def url
      "https://#{host}:443"
    end

    def handle_http_error(response)
      if response.body
        if (reason = response.body['reason'])
          klass = Lorkhan::Errors::Apple::MAPPINGS[reason]
          raise klass, response if klass
        end
      end
      raise Errors::HTTPError, response
    end

    def check_token_should_refresh
      return if @refresh_token_at.nil?
      refresh_token if Time.now.to_i >= @refresh_token_at
    end
  end
end
