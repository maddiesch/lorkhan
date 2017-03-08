require 'lorkhan/errors/base'
require 'lorkhan/errors/http_error'

module Lorkhan
  module Errors
    module Apple
      # The collapse identifier exceeds the maximum allowed size
      class BadCollapseId < Errors::HTTPError; end

      # The specified device token was bad.
      # Verify that the request contains a valid token and that the token matches the environment.
      class BadDeviceToken < Errors::HTTPError; end

      # The apns-expiration value is bad.
      class BadExpirationDate < Errors::HTTPError; end

      # The apns-id value is bad.
      class BadMessageId < Errors::HTTPError; end

      # The apns-priority value is bad.
      class BadPriority < Errors::HTTPError; end

      # The apns-topic was invalid.
      class BadTopic < Errors::HTTPError; end

      # The device token does not match the specified topic.
      class DeviceTokenNotForTopic < Errors::HTTPError; end

      # One or more headers were repeated.
      class DuplicateHeaders < Errors::HTTPError; end

      # Idle time out.
      class IdleTimeout < Errors::HTTPError; end

      # The device token is not specified in the request :path. Verify that the :path header contains the device token.
      class MissingDeviceToken < Errors::HTTPError; end

      # The apns-topic header of the request was not specified and was required.
      # The apns-topic header is mandatory when the client is
      # connected using a certificate that supports multiple topics.
      class MissingTopic < Errors::HTTPError; end

      # The message payload was empty.
      class PayloadEmpty < Errors::HTTPError; end

      # Pushing to this topic is not allowed.
      class TopicDisallowed < Errors::HTTPError; end

      # The provider token is stale and a new token should be generated.
      class ExpiredProviderToken < Errors::HTTPError; end

      # The specified action is not allowed.
      class Forbidden < Errors::HTTPError; end

      # The provider token is not valid or the token signature could not be verified
      class InvalidProviderToken < Errors::HTTPError; end

      # No provider certificate was used to connect to APNs and Authorization
      # header was missing or no provider token was specified.
      # The specified :method was not POST.
      class MissingProviderToken < Errors::HTTPError; end

      # The request contained a bad :path value.
      class BadPath < Errors::HTTPError; end

      # The specified :method was not POST.
      class MethodNotAllowed < Errors::HTTPError; end

      # The device token is inactive for the specified topic.
      class Unregistered < Errors::HTTPError; end

      # The message payload was too large.
      class PayloadTooLarge < Errors::HTTPError; end

      # The provider token is being updated too often.
      class TooManyProviderTokenUpdates < Errors::HTTPError; end

      # Too many requests were made consecutively to the same device token.
      class TooManyRequests < Errors::HTTPError; end

      # An internal server error occurred.
      class InternalServerError < Errors::HTTPError; end

      # The service is unavailable.
      class ServiceUnavailable < Errors::HTTPError; end

      # The server is shutting down.
      class Shutdown < Errors::HTTPError; end

      MAPPINGS = {
        'BadCollapseId' => BadCollapseId,
        'BadDeviceToken' => BadDeviceToken,
        'BadExpirationDate' => BadExpirationDate,
        'BadMessageId' => BadMessageId,
        'BadPriority' => BadPriority,
        'BadTopic' => BadTopic,
        'DeviceTokenNotForTopic' => DeviceTokenNotForTopic,
        'DuplicateHeaders' => DuplicateHeaders,
        'IdleTimeout' => IdleTimeout,
        'MissingDeviceToken' => MissingDeviceToken,
        'MissingTopic' => MissingTopic,
        'PayloadEmpty' => PayloadEmpty,
        'TopicDisallowed' => TopicDisallowed,
        'ExpiredProviderToken' => ExpiredProviderToken,
        'Forbidden' => Forbidden,
        'InvalidProviderToken' => InvalidProviderToken,
        'MissingProviderToken' => MissingProviderToken,
        'BadPath' => BadPath,
        'MethodNotAllowed' => MethodNotAllowed,
        'Unregistered' => Unregistered,
        'PayloadTooLarge' => PayloadTooLarge,
        'TooManyProviderTokenUpdates' => TooManyProviderTokenUpdates,
        'TooManyRequests' => TooManyRequests,
        'InternalServerError' => InternalServerError,
        'ServiceUnavailable' => ServiceUnavailable,
        'Shutdown' => Shutdown
      }.freeze
    end
  end
end
