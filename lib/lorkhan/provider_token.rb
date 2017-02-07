require 'jwt'
require 'openssl'

module Lorkhan
  class ProviderToken
    ALGORITHM = 'ES256'.freeze

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
