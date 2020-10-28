import 'dart:math';

import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/model/mobile_number.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';

class SenderModel extends ChangeNotifier {
  String campaignName = "";
  Duration duration = Duration(seconds: 0);
  String msg = "";
  List<MobileNumber> mobileNumbers = [];
  int head = 0;
  OperationStatus operationStatus = OperationStatus.Null;

  void setCampaign(Campaign campaign) {
    campaignName = campaign.campaignName;
    duration = campaign.delayDuration;
    msg = campaign.msg;
    mobileNumbers = campaign.addresses.map((x) => MobileNumber(x)).toList();

    head = 0;
    operationStatus = OperationStatus.Null;
  }

  void clearCampaign() {
    campaignName = "";
    duration = Duration(seconds: 0);
    msg = "";
    mobileNumbers = [];

    head = 0;
    operationStatus = OperationStatus.Null;
  }

  void setMobileNumberStateProgressing(int index) {
    mobileNumbers[index].mobileNumberState = MobileNumberState.Processing;
    notifyListeners();
  }

  void setMobileNumberStateSent(int index) {
    mobileNumbers[index].mobileNumberState = MobileNumberState.Sent;
    notifyListeners();
  }

  void setStateToProgressing() {
    for (int i = 0; i < mobileNumbers.length; i++) {
      setMobileNumberStateProgressing(i);
    }
  }

  void initiateSending() {
    head = 0;
    operationStatus = OperationStatus.Sending;
    sendSMS();
    notifyListeners();
  }

  void startPauseOperation() {
    if (operationStatus == OperationStatus.Sending) {
      operationStatus = OperationStatus.Paused;
      print("Pause");
    } else if (operationStatus == OperationStatus.Paused) {
      operationStatus = OperationStatus.Sending;
      sendSMS();
      print("Start");
    }
    notifyListeners();
  }

  void completeOperation() {
    operationStatus = OperationStatus.Complete;
    notifyListeners();
  }

  void sendSMS() async {
    print("Send SMS Start");
    final _sender = SmsSender();
    Random _random = Random();
    try {
      while (head < mobileNumbers.length &&
          operationStatus == OperationStatus.Sending) {
        Duration _randomDuration =
            duration + Duration(seconds: _random.nextInt(10 - 5));

        print(_randomDuration.toString());

        await Future.delayed(_randomDuration, () async {
          print("Message sending to " + mobileNumbers[head].number.toString());
          await _sender.sendSms(
            SmsMessage(mobileNumbers[head].number.toString(), msg),
          );
          print("Message sent to " + mobileNumbers[head].number.toString());
          setMobileNumberStateSent(head);
          head++;
          notifyListeners();
        });
      }
    } catch (e) {
      print(e.toString());
    }

    if (head == mobileNumbers.length) {
      operationStatus = OperationStatus.Complete;
      notifyListeners();
    }
  }
}

enum OperationStatus {
  Null,
  Sending,
  Paused,
  Complete,
}
