<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Better Auth Client

A Flutter client for the Better Auth authentication service. Provides simple and secure authentication features with deep linking support for seamless social authentication flows.

## Features

- Email and password authentication
- Social authentication (GitHub, Google, etc.)
- Secure token storage
- Flexible deep link handling for OAuth flows
- Cross-platform compatibility

## Getting started

Add the package to your pubspec.yaml:

```yaml
dependencies:
  better_auth_client: ^0.0.1
```

Then run:

```
flutter pub get
```

## Deep Linking Setup

The package includes deep linking functionality using the `app_links` package. Deep links need to be configured in your native app configurations (Android/iOS) and are required for social authentication flows to redirect back to your app after completing authentication.

For detailed setup instructions, see the [NATIVE_DEEP_LINK_SETUP.md](NATIVE_DEEP_LINK_SETUP.md) guide.

## Usage

### Initialize the client

```dart
final authClient = BetterAuthClient(
  config: BetterAuthConfig(
    baseUrl: 'https://your-auth-backend.com',
    clientId: 'your-client-id',
  ),
  // Optional: only if your server needs a specific callback URL
  serverCallbackUrl: 'https://your-backend.com/auth/callback',
);
```

### Email authentication

```dart
// Sign in
try {
  final user = await authClient.signInWithEmail(
    email: 'user@example.com',
    password: 'password',
  );
  print('Signed in: ${user.email}');
} catch (e) {
  print('Error signing in: $e');
}

// Sign up
try {
  final user = await authClient.signUpWithEmail(
    email: 'newuser@example.com',
    password: 'password',
  );
  print('Signed up: ${user.email}');
} catch (e) {
  print('Error signing up: $e');
}
```

### Social authentication

```dart
// Sign in with GitHub
try {
  await authClient.signInWithSocial('github');
  // The app will open the GitHub authentication page
  // After authentication, it will redirect back to your app via deep linking
} catch (e) {
  print('Error with social sign-in: $e');
}
```

### Listen to authentication state changes

```dart
authClient.authStateChanges.listen((state) {
  if (state == AuthState.authenticated) {
    print('User is authenticated: ${authClient.currentUser?.email}');
  } else {
    print('User is not authenticated');
  }
});
```

### Sign out

```dart
await authClient.signOut();
```

## Cleanup

```dart
// Make sure to dispose the client when no longer needed
authClient.dispose();
```

## Additional Information

For more detailed examples, check out the `/example` folder in the repository.

### Contributing

Contributions are welcome! If you encounter any issues or have feature requests, please file them in the issues section of the repository.
