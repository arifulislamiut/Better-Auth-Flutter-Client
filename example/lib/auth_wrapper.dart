import 'package:better_auth_client/better_auth_client.dart';
import 'package:flutter/material.dart';

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
        if (snapshot.hasData) {
          return onAuthenticatedChild;
        }
        return onAuthorizedChild;
      },
    );
  }
}
