## Lorkhan

[![CircleCI](https://circleci.com/gh/skylarsch/lorkhan/tree/master.svg?style=svg)](https://circleci.com/gh/skylarsch/lorkhan/tree/master) [![Code Climate](https://lima.codeclimate.com/github/skylarsch/lorkhan/badges/gpa.svg)](https://lima.codeclimate.com/github/skylarsch/lorkhan) [![Issue Count](https://lima.codeclimate.com/github/skylarsch/lorkhan/badges/issue_count.svg)](https://lima.codeclimate.com/github/skylarsch/lorkhan)

Apple Push Notification Services client using the HTTP/2 API and Provider Authentication Tokens

### Getting Provider Authentication Tokens

See: "Generate a universal provider token signing key" under "Configure push notifications." in [Xcode Help](http://help.apple.com/xcode)

### Sending a Push Notification

```ruby
token = Lorkhan::ProviderToken.new(key_id: '<token key id>', team_id: '<developer team id>', secret: '<PAT secret>')
connection = Lorkhan::Connection.new(production: true, token: token)

notification = Lorkhan::Notification.new('<device token>')
notification.topic = '<your app ID>'
notification.alert = 'Hello from Lorkhan'

connection.push(notification)
```

### Other Gotcha's

- Your OpenSSL implementation __MUST__ support the `ES256` elliptical curve.

### Extra reading

##### [Local and Remote Notification Programming Guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW1)
