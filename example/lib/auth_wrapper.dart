import 'package:better_auth_client/better_auth_client.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class AuthWrapperWidget extends StatelessWidget {
  final Widget onAuthenticatedChild;
  final Widget onAuthorizedChild;
  const AuthWrapperWidget({
    super.key,
    required this.onAuthenticatedChild,
    required this.onAuthorizedChild,
  });
  static final _auth = BetterAuthClient.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.userChanges,
      builder: (context, snapshot) {
        dev.log('🔄 AuthWrapper: Stream state: ${snapshot.connectionState}, hasData: ${snapshot.hasData}, data: ${snapshot.data?.email}');
        
        // Show loading while checking authentication
        if (snapshot.connectionState == ConnectionState.waiting) {
          dev.log('⏳ AuthWrapper: Waiting for auth state...');
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        // If we have user data, show authenticated screen
        if (snapshot.hasData && snapshot.data != null) {
          dev.log('✅ AuthWrapper: User authenticated: ${snapshot.data!.email}');
          return onAuthenticatedChild;
        }
        
        // Otherwise show login/signup screen
        dev.log('🔒 AuthWrapper: Not authenticated, showing auth screen');
        return onAuthorizedChild;
      },
    );
  }
}
