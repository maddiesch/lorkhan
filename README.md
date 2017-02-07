## Lorkhan

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
