# Native Deep Link Configuration for Better Auth Client

This guide explains how to set up deep links in your native app configurations (Android and iOS) for the Better Auth Client in your Flutter application. Deep links are required for the authentication flow to redirect back to your app after completing authentication with identity providers.

## Overview

The Better Auth Client package requires native deep link configuration to handle authentication callbacks from OAuth providers. This approach allows you to:

1. Fully control your app's URL scheme in native configuration
2. Configure multiple URL schemes if needed
3. Support both custom URL schemes and universal/app links
4. Work with existing deep link configurations in your app

## 1. Configure Android

### Step 1: Update AndroidManifest.xml

Open your `android/app/src/main/AndroidManifest.xml` file and add the following inside the `<activity>` element:

```xml
<!-- Deep linking for authentication callbacks -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- Define your custom scheme and path -->
    <data
        android:scheme="YOUR_SCHEME"
        android:host="YOUR_HOST"
        android:pathPrefix="/YOUR_PATH" />
</intent-filter>
```

Replace:
- `YOUR_SCHEME` with your app's URL scheme (e.g., `myapp`)
- `YOUR_HOST` and `YOUR_PATH` with your preferred path structure

**Important**: The deep link must include a path that can receive a `code` parameter in the query string. For example: `myapp://auth/callback?code=xyz123`

### Example

```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="myauthapp"
        android:host="login"
        android:pathPrefix="/callback" />
</intent-filter>
```

This would handle links like: `myauthapp://login/callback?code=xyz123`

### Step 2: Update MainActivity (Optional for App Links)

If you're using App Links (verified deep links), add this to your `MainActivity.kt`:

```kotlin
override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    // This helps with App Links
    val intent = intent
    val dataString = intent.dataString
    if (dataString != null) {
        intent.putExtra("initial_link", dataString)
    }
}
```

## 2. Configure iOS

### Step 1: Update Info.plist

Open your `ios/Runner/Info.plist` file and add the following:

```xml
<!-- URL scheme declaration -->
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>YOUR_BUNDLE_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_SCHEME</string>
        </array>
    </dict>
</array>
```

Replace:
- `YOUR_BUNDLE_ID` with your app's bundle ID (e.g., `com.example.myapp`)
- `YOUR_SCHEME` with your app's URL scheme (e.g., `myapp`)

### Example

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.example.myauthapp</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>myauthapp</string>
        </array>
    </dict>
</array>
```

### Step 2: Universal Links (Optional but recommended)

For Universal Links, add the following to your `Info.plist`:

```xml
<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:YOUR_DOMAIN</string>
</array>
```

Replace `YOUR_DOMAIN` with your website domain.

## 3. Server Callback Configuration

When initializing the BetterAuthClient, you can optionally provide a server callback URL if your backend needs it:

```dart
final authClient = BetterAuthClient(
  config: BetterAuthConfig(
    baseUrl: 'https://your-auth-backend.com',
    clientId: 'your-client-id',
  ),
  serverCallbackUrl: 'https://your-backend.com/auth/callback', // Optional: only if your server needs a callback URL
);
```

If `serverCallbackUrl` is not provided, the server will be expected to redirect directly to your app's deep link (which you configured in the native configs).

## 4. Testing Deep Links

### Android
```
adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "your-scheme://your-path?code=test-code"
```

### iOS Simulator
```
xcrun simctl openurl booted "your-scheme://your-path?code=test-code"
```

## Troubleshooting

1. **Deep links not working on Android**: Make sure your `launchMode` is set to `singleTask` or `singleTop` in the AndroidManifest.xml.

2. **Deep links not working on iOS**: Check that your URL scheme doesn't have any special characters or uppercase letters.

3. **App not returning from browser**: Make sure you're using `LaunchMode.externalApplication` when opening the auth URL.

4. **Not receiving the auth code**: Ensure that your OAuth provider is correctly appending the `code` parameter to the redirect URL.

5. **Multiple URL scheme configurations**: If your app already has URL scheme configurations, you can add additional schemes or update existing ones. The package will handle any deep link that contains a `code` parameter.

## Additional Resources

- [App Links documentation](https://pub.dev/packages/app_links)
- [Android App Links documentation](https://developer.android.com/training/app-links)
- [iOS Universal Links documentation](https://developer.apple.com/ios/universal-links/) 