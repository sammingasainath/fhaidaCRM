import 'package:telephony/telephony.dart';

class SmsService {
  static final Telephony telephony = Telephony.instance;

  static Future<void> sendSms({
    required String message,
    required String recipient,
    Function(bool)? onComplete,
  }) async {
    try {
      bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;

      if (permissionsGranted != null && permissionsGranted) {
        await telephony.sendSms(
          to: recipient,
          message: message,
        );
        print('SMS sent successfully');
        if (onComplete != null) {
          onComplete(true);
        }
      } else {
        print('SMS permissions not granted');
        if (onComplete != null) {
          onComplete(false);
        }
      }
    } catch (error) {
      print('Error sending SMS: $error');
      if (onComplete != null) {
        onComplete(false);
      }
    }
  }
}