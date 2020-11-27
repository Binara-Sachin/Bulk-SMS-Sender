import 'package:bulk_sms_sender/core/model/enums.dart';

class MobileNumber {
  final String number;
  MobileNumberState mobileNumberState = MobileNumberState.NULL;

  MobileNumber(this.number);
}
