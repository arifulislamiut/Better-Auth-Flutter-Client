abstract class ApiEndpoints {
  static const _prefix = '/api/auth';
  static const String signIn = '$_prefix/sign-in/email';
  static const String signInSocial = '$_prefix/sign-in/social';
  static const String signUp = '$_prefix/sign-up/email';
  static const String resetPassword = '$_prefix/reset-password';
  static const String sendVerificationEmail =
      '$_prefix/send-verification-email';
  static const String forgetPassword = '$_prefix/forget-password';
}
