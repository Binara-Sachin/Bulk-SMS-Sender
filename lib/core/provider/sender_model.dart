import 'dart:math';

import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/model/enums.dart';
import 'package:bulk_sms_sender/core/model/mobile_number.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_maintained/sms.dart';

class SenderModel extends ChangeNotifier {
  String campaignName = "";
  Duration duration = Duration(seconds: 0);
  String msg = "";
  List<MobileNumber> mobileNumbers = [];
  int head = 0;
  OperationStatus operationStatus = OperationStatus.Null;

  void setCampaign(Campaign campaign, int newHead) async {
    campaignName = campaign.campaignName;
    duration = campaign.delayDuration;
    msg = campaign.msg;
    mobileNumbers = campaign.addresses.map((x) => MobileNumber(x)).toList();

    head = newHead;
    operationStatus = OperationStatus.Null;

    if (head != 0) {
      for (var i = 0; i < newHead; i++) {
        mobileNumbers[i].mobileNumberState = MobileNumberState.Sent;
      }
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('ongoingCampaign', campaign.id);
    await preferences.setInt('ongoingHead', head);
  }

  // void clearCampaign() {
  //   campaignName = "";
  //   duration = Duration(seconds: 0);
  //   msg = "";
  //   mobileNumbers = [];

  //   head = 0;
  //   operationStatus = OperationStatus.Null;
  // }

  // void setMobileNumberStateProgressing(int index) {
  //   mobileNumbers[index].mobileNumberState = MobileNumberState.Processing;
  //   notifyListeners();
  // }

  // void setMobileNumberStateSent(int index) {
  //   mobileNumbers[index].mobileNumberState = MobileNumberState.Sent;
  //   notifyListeners();
  // }

  // void setStateToProgressing() {
  //   for (int i = 0; i < mobileNumbers.length; i++) {
  //     setMobileNumberStateProgressing(i);
  //   }
  // }

  void initiateSending() {
    head = 0;
    operationStatus = OperationStatus.Sending;
    sendBulkSMS();
    notifyListeners();
  }

  void startPauseOperation() {
    if (operationStatus == OperationStatus.Sending) {
      operationStatus = OperationStatus.Paused;
      print("Pause");
    } else if (operationStatus == OperationStatus.Paused) {
      operationStatus = OperationStatus.Sending;
      sendBulkSMS();
      print("Start");
    }
    notifyListeners();
  }

  // void completeOperation() {
  //   operationStatus = OperationStatus.Complete;
  //   notifyListeners();
  // }

  Future<void> sendSMS(MobileNumber mobileNumber) async {
    try {
      final _sender = SmsSender();
      SimCardsProvider _simCardProvider = new SimCardsProvider();
      SimCard _card = await _simCardProvider.getSimCards().then((value) => value[0]);

      SmsMessage message = new SmsMessage(mobileNumber.number, msg);
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          mobileNumber.mobileNumberState = MobileNumberState.Sent;
        } else if (state == SmsMessageState.Delivered) {
          mobileNumber.mobileNumberState = MobileNumberState.Delivered;
        } else if (state == SmsMessageState.Fail) {
          mobileNumber.mobileNumberState = MobileNumberState.Failed;
        }
        notifyListeners();
      });

      await _sender.sendSms(message, simCard: _card);
    } catch (e) {
      operationStatus = OperationStatus.Error;
      notifyListeners();
      print(e.toString());
    }
  }

  void sendBulkSMS() async {
    print("Send SMS Start");

    Random _random = Random();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    while (head < mobileNumbers.length && operationStatus == OperationStatus.Sending) {
      Duration _randomDuration = duration + Duration(seconds: _random.nextInt(10 - 5));
      print(head.toString());
      print(_randomDuration.toString());

      await Future.delayed(_randomDuration, () async {
        sendSMS(mobileNumbers[head]);
        head++;
      });

      await preferences.setInt('ongoingHead', head);
    }

    print("Send SMS Start");

    if (head == mobileNumbers.length) {
      operationStatus = OperationStatus.Complete;
      await preferences.setInt('ongoingCampaign', -1);

      notifyListeners();
      print("Send SMS Complete");
    }
  }
}
