require 'jwt'
require 'openssl'

module Lorkhan
  ##
  # Wrapper for creating the authentication token for communicating with Apple's servers.
  #
  # See the "Provider Authentication Tokens" from Apple's "Local and Remote Notification Programming Guide"
  # https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW1
  ##
  class ProviderToken
    ALGORITHM = 'ES256'.freeze

    ##
    # Create a new token
    #
    # key_id: An alphanumeric string obtained from the developer portal.
    # team_id: The team id for your developer account.  Obtained from the developer portal.
    # secret: The content of the Authentication Token key file obtained from the developer portal.
    ##
    def initialize(key_id:, team_id:, secret:)
      @key_id  = key_id
      @team_id = team_id
      @secret  = secret
    end

    def encode
      JWT.encode(payload, p_key, ALGORITHM, headers)
    end

    private

    def p_key
      @p_key ||= begin
        sec = OpenSSL::PKey::EC.new(@secret)
        sec.check_key
        sec
      end
    end

    def payload
      {
        iss: @team_id,
        iat: Time.now.utc.to_i
      }
    end

    def headers
      {
        kid: @key_id
      }
    end
  end
end
