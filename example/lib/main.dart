import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:better_auth_client/better_auth_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Auth Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeAuthClient();
  }

  Future<void> _initializeAuthClient() async {
    BetterAuthClient.create(
      baseUrl: 'http://192.168.1.9:4000',
    );

    // // Listen to auth state changes
    // _authClient.authStateChanges.listen((state) {
    //   if (state == AuthState.authenticated && mounted) {
    //     //Navigator.of(context).pushReplacement(
    //     // MaterialPageRoute(
    //     //   builder: (context) => HomeScreen(
    //     //     authClient: _authClient,
    //     //     /user: _authClient.currentUser!,
    //     //   ),
    //     //),
    //     //  );
    //   }
    // });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // _authClient.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _error = 'Please fill in all fields');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final auth = BetterAuthClient.instance;
      if (_isLogin) {
        await auth.signIn.email(
          email: _emailController.text,
          password: _passwordController.text,
          onSuccess: (ctx) {
            log("Success ${ctx.toString()}");
          },
          onError: (error) {
            log("Error ${error.message.toString()}");
          },
        );
      } else {
        await auth.signUp.email(
          email: _emailController.text,
          password: _passwordController.text,
          name: "John Doe",
          image: "https://example.com/image.png",
          callbackUrl: "https://example.com/callback",
          data: {},
          onSuccess: (context) {
            log("Success ${context.toString()}");
          },
          onError: (error) {
            log("Error ${error.toString()}");
          },
        );
      }
      final currentUser = await auth.getCurrentUser();
      log("Current User ${currentUser.toString()}");
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithSocial(String provider) async {
    final auth = BetterAuthClient.instance;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await auth.signIn.social(
        provider: Providers.google,
        onSuccess: (context) {
          log("Success ");
        },
        onError: (context) {
          log("Error ");
        },
      );
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<User?>(
          stream: BetterAuthClient.instance.userChanges,
          builder: (context, snapshot) {
            return Text(snapshot.data?.email ?? 'Sign In');
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isLogin ? 'Sign In' : 'Sign Up'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : () => _signInWithSocial('github'),
              icon: const Icon(Icons.code),
              label: const Text('Sign in with GitHub'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : () => _signInWithSocial('google'),
              icon: const Icon(Icons.login),
              label: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () => setState(() => _isLogin = !_isLogin),
              child: Text(_isLogin
                  ? 'Need an account? Sign up'
                  : 'Have an account? Sign in'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : BetterAuthClient.instance.signOut,
              child: const Text('Sign out'),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deep Link Configuration:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'URL Scheme: betterauth://authentication/oauth2redirect',
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'This URL is configured in the native Android/iOS files and will receive the OAuth callback with the authentication code.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
