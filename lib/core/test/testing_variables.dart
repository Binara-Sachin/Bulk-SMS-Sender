import 'package:bulk_sms_sender/core/model/campaign.dart';

List<String> _testingMobileNumbers = [
  "1234567901",
  "1234567902",
  "1234567903",
  "1234567904",
  "1234567905",
  "1234567906",
  "1234567907",
  "1234567908",
  "1234567909",
  "1234567900"
];

List<Campaign> testCampaigns = [
  Campaign(
    id: 0,
    campaignName: "Test Campaign 01",
    msg: "Test Message",
    addresses: _testingMobileNumbers,
    delayDuration: Duration(seconds: 10),
    lastRun: DateTime.now(),
  ),
  Campaign(
    id: 1,
    campaignName: "Test Campaign 02",
    msg: "Test Message 2",
    addresses: _testingMobileNumbers,
    delayDuration: Duration(seconds: 10),
    lastRun: DateTime.now(),
  ),
];
