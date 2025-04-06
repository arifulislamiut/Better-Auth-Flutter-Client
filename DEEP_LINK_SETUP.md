# Deep Link Setup Guide for Better Auth Client

This guide explains how to set up deep links for the Better Auth Client in your Flutter application. Deep links enable the authentication flow to redirect back to your app after completing authentication with the identity provider.

## Prerequisites

1. The `app_links` package is already included in the Better Auth Client package.
2. You'll need to decide on a URL scheme for your app (e.g., `myapp`).
3. You can customize the callback path used for deep linking.

## 1. Configure Android

### Step 1: Update AndroidManifest.xml

Open your `android/app/src/main/AndroidManifest.xml` file and add the following inside the `<activity>` element:

```xml
<!-- Deep linking -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- Accepts URIs that begin with YOUR_SCHEME://YOUR_CALLBACK_PATH -->
    <data
        android:scheme="YOUR_SCHEME"
        android:host="YOUR_HOST"
        android:pathPrefix="/YOUR_PATH" />
</intent-filter>
```

Replace:
- `YOUR_SCHEME` with the scheme you're using in your app (the same scheme you provided in the `BetterAuthConfig`)
- `YOUR_HOST` and `YOUR_PATH` with the appropriate parts of your custom callback path

For example, if your custom callback path is `auth/callback`, then:
- `YOUR_HOST` should be `auth`
- `YOUR_PATH` should be `/callback`

If your custom callback path is just `callback`, then:
- `YOUR_HOST` should be `callback`
- There's no need for a pathPrefix in this case

### Step 2: Update MainActivity.kt (Optional for AppLinks)

If you want to support App Links (verified deep links), you will need to add the following to your `MainActivity.kt`:

```kotlin
override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    // This helps with the verified App Links
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
- `YOUR_SCHEME` with the scheme you're using in your app

For iOS, you only need to specify the URL scheme, as it will handle all paths automatically.

### Step 2: Universal Links (Optional)

For Universal Links (verified deep links), add the following to your `Info.plist`:

```xml
<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:YOUR_DOMAIN</string>
</array>
```

Replace `YOUR_DOMAIN` with your website domain.

## 3. Configure Your App with Custom Callback Path

In your main app, initialize the Better Auth Client with your preferred URL scheme and custom callback path:

```dart
final authClient = BetterAuthClient(
  config: BetterAuthConfig(
    baseUrl: 'https://your-auth-backend.com',
    scheme: 'your-app-scheme', // The scheme you configured in Android/iOS
    clientId: 'your-client-id',
    callbackPath: 'custom/callback/path', // Custom callback path (default is 'auth/callback')
  ),
);
```

The `callbackPath` parameter allows you to customize the deep link path used for auth callbacks. Make sure this matches the configuration in your AndroidManifest.xml.

## 4. Testing Deep Links with Custom Paths

### Android
```
adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "your-app-scheme://custom/callback/path?code=test-code"
```

### iOS Simulator
```
xcrun simctl openurl booted "your-app-scheme://custom/callback/path?code=test-code"
```

## Troubleshooting

1. **Deep links not working on Android**: Make sure your `launchMode` is set to `singleTask` or `singleTop` in the AndroidManifest.xml.

2. **Deep links not working on iOS**: Check that your URL scheme doesn't have any special characters or uppercase letters.

3. **App not returning from browser**: Make sure you're using `LaunchMode.externalApplication` when opening the auth URL.

4. **Getting errors when calling the backend**: Make sure your callback URL matches exactly what your backend expects.

5. **Custom path not being recognized**: Ensure your deep link pattern in AndroidManifest.xml matches the callbackPath configured in the BetterAuthConfig.

## Additional Resources

- [App Links documentation](https://pub.dev/packages/app_links)
- [Android App Links documentation](https://developer.android.com/training/app-links)
- [iOS Universal Links documentation](https://developer.apple.com/ios/universal-links/) 