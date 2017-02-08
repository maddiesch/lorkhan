require 'lorkhan/errors/base'
require 'lorkhan/errors/http_error'

module Lorkhan
  module Errors
    module Apple
      class BadCollapseId < Errors::HTTPError; end
      class BadDeviceToken < Errors::HTTPError; end
      class BadExpirationDate < Errors::HTTPError; end
      class BadMessageId < Errors::HTTPError; end
      class BadPriority < Errors::HTTPError; end
      class BadTopic < Errors::HTTPError; end
      class DeviceTokenNotForTopic < Errors::HTTPError; end
      class DuplicateHeaders < Errors::HTTPError; end
      class IdleTimeout < Errors::HTTPError; end
      class MissingDeviceToken < Errors::HTTPError; end
      class MissingTopic < Errors::HTTPError; end
      class PayloadEmpty < Errors::HTTPError; end
      class TopicDisallowed < Errors::HTTPError; end
      class ExpiredProviderToken < Errors::HTTPError; end
      class Forbidden < Errors::HTTPError; end
      class InvalidProviderToken < Errors::HTTPError; end
      class MissingProviderToken < Errors::HTTPError; end
      class BadPath < Errors::HTTPError; end
      class MethodNotAllowed < Errors::HTTPError; end
      class Unregistered < Errors::HTTPError; end
      class PayloadTooLarge < Errors::HTTPError; end
      class TooManyProviderTokenUpdates < Errors::HTTPError; end
      class TooManyRequests < Errors::HTTPError; end
      class InternalServerError < Errors::HTTPError; end
      class ServiceUnavailable < Errors::HTTPError; end
      class Shutdown < Errors::HTTPError; end
    end
  end
end
