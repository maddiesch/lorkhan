require 'json'
require 'securerandom'

module Lorkhan
  ##
  # Describes a push notification
  #
  # Required attributes
  #
  #   - token: The device token to deliver the notification to
  #   - apns_id: The APNS id for the notification.
  #              This *must* be a UUID and is created when the instance is initialized.
  #   - priority: The priority of the notification.  Apple will use this to determine how to deliver the notification.
  #               See `PRIORITY_DELIVER_IMMEDIATELY` & `PRIORITY_DELIVER_BACKGROUND` for more info.
  #   - expiration: A UNIX UTC epoch expressed in seconds for how long Apple will retain the notification,
  #                 and attempt redelivery.  A 0 time will attempt a single delivery then disguard the message.
  #   - topic: The topic of the remote notification, which is typically the bundle ID for your app.
  #            The certificate you create in your developer account must include the capability for this topic.
  #
  # Optional attributes
  #
  #   - alert: The message displayed to the user.
  #   - badge: The badge number displayed on the app icon.
  #   - category: The category for the notification.  Used to provide direct notification actions.
  #   - collapse_id: Used to group multiple notifications on the screen.
  #   - content_available: A boolean if this should be a content available push.
  #                        This will deliver a silent notification to the device.
  #                        Your app's entitlements must be enabled.
  #                        If the value for this is truthy, the alert, badge, sound will be ignored.
  #   - custom_payload: A custom hash of data to send.  Must be JSON encodable.
  #   - mutable_content: A `1` if the notificaiton is mutable.
  #                      See `UNNotificationServiceExtension` (https://developer.apple.com/reference/usernotifications/unnotificationserviceextension)
  #   - sound: The name of a bundled sound file to play.
  #   - url_args: Used in conjunction with the `urlFormatString` in
  #               the `website.json` file for sending web notifications.
  ##
  class Notification
    ##
    # Send the push message immediately.
    # Notifications with this priority must trigger an alert, sound, or badge on the target device.
    ##
    PRIORITY_DELIVER_IMMEDIATELY = 10

    ##
    # Send the push message at a time that takes into account power considerations for the device.
    # Notifications with this priority might be grouped and delivered in bursts.
    ##
    PRIORITY_DELIVER_BACKGROUND  = 5

    attr_reader :token, :apns_id, :priority, :alert, :content_available
    attr_accessor :custom_payload, :badge, :sound, :category, :url_args, :mutable_content
    attr_accessor :expiration, :topic, :collapse_id

    ##
    # Create a new notification
    #
    # token: The Device token that the notification will be delivered to
    ##
    def initialize(token)
      @token = token
      @apns_id = SecureRandom.uuid
      @expiration = 0
      @content_available = false
      @priority = PRIORITY_DELIVER_IMMEDIATELY
    end

    def body
      JSON.dump(to_h).force_encoding(Encoding::BINARY)
    end

    def push_type
      return 'background' if content_available == true

      'alert'
    end

    def alert=(alert)
      @alert = alert
      if @alert
        @content_available = false
        @priority = PRIORITY_DELIVER_IMMEDIATELY
      end
    end

    def content_available=(content_available)
      @content_available = content_available
      if content_available == true
        @alert = nil
        @priority = PRIORITY_DELIVER_BACKGROUND
      end
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
          aps['mutable-content'] = 1 if mutable_content
        end
        root.merge!(custom_payload) if custom_payload
      end
    end
  end
end
