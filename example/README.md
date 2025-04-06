# Better Auth Client Example

This example demonstrates how to use the Better Auth client in a Flutter application.

## Features

- Email/password authentication (sign in and sign up)
- Social authentication (Google)
- Authentication state management
- User profile display
- Secure token storage

## Getting Started

1. Replace the placeholder values in `lib/main.dart`:
   ```dart
   _authClient = BetterAuthClient(
     config: const BetterAuthConfig(
       baseUrl: 'YOUR_BETTER_AUTH_URL', // Replace with your Better Auth URL
       scheme: 'better-auth-example',
       clientId: 'YOUR_CLIENT_ID', // Replace with your client ID
     ),
   );
   ```

2. Configure your Better Auth backend:
   - Set up the email/password authentication
   - Configure Google OAuth
   - Add the redirect URI: `better-auth-example://auth-callback`

3. Run the app:
   ```bash
   flutter run
   ```

## Structure

- `lib/main.dart` - Main application file with authentication screen
- `lib/home_screen.dart` - Screen shown after successful authentication

## Features Demonstrated

1. Authentication Flow
   - Email/password sign in
   - Email/password sign up
   - Google sign in
   - Sign out

2. State Management
   - Loading states
   - Error handling
   - Authentication state changes

3. User Interface
   - Form validation
   - Loading indicators
   - Error messages
   - Profile display

## Notes

- This is a basic example. In a production app, you would want to add:
  - More robust error handling
  - Input validation
  - Loading states for social auth
  - Proper deep link handling
  - Refresh token management
  - Biometric authentication
  - More social providers
