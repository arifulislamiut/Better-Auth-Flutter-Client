import 'package:better_auth_client/src/core/types.dart';
import 'package:better_auth_client/src/plugins/phone-auth/phone_auth_plugin.dart';

class PhoneNumberAuthPluginImpl implements PhoneAuthPlugin {
  @override
  Future<void> forgetPassword({
    required String phone,
    Success? onSuccess,
    Error? onError,
  }) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  resetPassword({
    required String otp,
    required String phoneNumber,
    required String newPassword,
    Success? onSuccess,
    Error? onError,
  }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> sendOtp({
    required String phone,
    Success? onSuccess,
    Error? onError,
  }) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future<void> verify({
    required String phone,
    required String otp,
    bool updatePhoneNumber = false,
    bool disableSession = true,
    Success? onSuccess,
    Error? onError,
  }) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
