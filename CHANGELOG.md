### 0.0.4

- Added `Lorkhan::Notification::DEFAULT_SOUND_NAME`

### 0.0.3

- Sending a `content_available` push, now excludes the `alert`, `badge`, `sound` keys.

### 0.0.2

- Calling `Lorkan::Connection#push` will automatically check when the auth token was generated and refresh the token if needed.
