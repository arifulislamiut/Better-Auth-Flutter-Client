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

A Flutter client for authentication that provides simple and secure authentication features for your Flutter applications.

## Features

- Email and password authentication (sign in and sign up)
- Social authentication (GitHub, Google, etc.)
- User state management with streams
- Cross-platform compatibility

## Getting started

Add the package to your pubspec.yaml:

```yaml
dependencies:
  better_auth_client:
    git:
      url: https://github.com/mrnpro/Better-Auth-Flutter-Client.git
```

Then run:

```
flutter pub get
```

## Usage

### Initialize the client

Initialize the BetterAuthClient in your main method before running your app:

```dart
void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the authentication client
  BetterAuthClient.create(
    baseUrl: 'https://your-auth-api.com',
  );
  
  // Run your app
  runApp(MyApp());
}
```

This ensures that authentication is properly set up before your application starts and is available throughout your entire app.

### Email authentication

```dart
// Sign in
final auth = BetterAuthClient.instance;
await auth.signIn.email(
  email: 'user@example.com',
  password: 'password123',
  onSuccess: (context) {
    print("Success: ${context.toString()}");
  },
  onError: (error) {
    print("Error: ${error.message.toString()}");
  },
);

// Sign up
await auth.signUp.email(
  email: 'user@example.com',
  password: 'password123',
  name: "John Doe",
  image: "https://example.com/image.png",
  callbackUrl: "https://example.com/callback",
  data: {}, // Additional user data
  onSuccess: (context) {
    print("Success: ${context.toString()}");
  },
  onError: (error) {
    print("Error: ${error.toString()}");
  },
);
```

### Social authentication

```dart
await auth.signIn.social(
  provider: Providers.google, // or Providers.github
  onSuccess: (context) {
    print("Success");
  },
  onError: (context) {
    print("Error");
  },
);
```

### Get Current User

```dart
final currentUser = await auth.getCurrentUser();
print("Current User: ${currentUser.toString()}");
```

### Listen to authentication state changes

```dart
BetterAuthClient.instance.userChanges.listen((user) {
  if (user != null) {
    print("User is authenticated: ${user.email}");
  } else {
    print("User is not authenticated");
  }
});
```

### Sign out

```dart
await BetterAuthClient.instance.signOut();
```

## Example

For a complete example, check out the `example` folder in the repository.

### Contributing

Contributions are welcome! If you encounter any issues or have feature requests, please file them in the issues section of the repository.