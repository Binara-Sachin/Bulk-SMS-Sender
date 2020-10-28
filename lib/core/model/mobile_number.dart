class MobileNumber {
  final String number;
  MobileNumberState mobileNumberState = MobileNumberState.NULL;

  MobileNumber(this.number);
}

enum MobileNumberState {
  NULL,
  Processing,
  Sent,
}
