import 'package:flutter_test/flutter_test.dart';
import 'package:better_auth_client/better_auth_client.dart';

void main() {
  group('TwoFactorClient', () {
    test('TwoFactorClientImpl can be instantiated', () {
      final client = TwoFactorClientImpl();
      expect(client, isNotNull);
    });

    test('TwoFactorSetupData can be created from JSON', () {
      final json = {
        'secret': 'JBSWY3DPEHPK3PXP',
        'qrCodeUrl':
            'otpauth://totp/Test:user@example.com?secret=JBSWY3DPEHPK3PXP',
        'backupCodes': '123456\n789012\n345678',
      };

      final setupData = TwoFactorSetupData.fromJson(json);

      expect(setupData.secret, 'JBSWY3DPEHPK3PXP');
      expect(
        setupData.qrCodeUrl,
        'otpauth://totp/Test:user@example.com?secret=JBSWY3DPEHPK3PXP',
      );
      expect(setupData.backupCodes, '123456\n789012\n345678');
    });

    test('TwoFactorEnableResponse can be created from JSON', () {
      final json = {'enabled': true, 'backupCodes': '111111\n222222\n333333'};

      final response = TwoFactorEnableResponse.fromJson(json);

      expect(response.enabled, true);
      expect(response.backupCodes, '111111\n222222\n333333');
    });
  });
}
