import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/model/enums.dart';
import 'package:bulk_sms_sender/core/services/local_storage.dart';
import 'package:bulk_sms_sender/core/test/testing_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignsModel extends ChangeNotifier {
  final LocalStorage localStorage = new LocalStorage();

  List<Campaign> savedCampaigns;
  int ongoingCampaign;
  int ongoingHead;

  DataState dataState = DataState.Null;
  bool loading = false;

  void testCampaign() {
    savedCampaigns = testCampaigns;
    localStorage.writeFile(savedCampaigns);
    notifyListeners();
  }

  void saveCampaign(Campaign campaign) async {
    savedCampaigns.add(campaign);
    localStorage.writeFile(savedCampaigns);
    notifyListeners();
  }

  void deleteCampaign(Campaign campaign) async {
    savedCampaigns.remove(campaign);
    localStorage.writeFile(savedCampaigns);
    notifyListeners();
  }

  void readCampaigns() async {
    loading = true;
    notifyListeners();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    ongoingHead = preferences.getInt('ongoingHead') ?? 0;
    ongoingCampaign = preferences.getInt('ongoingCampaign') ?? -1;

    ongoingCampaign = 1;
    ongoingHead = 2;

    await localStorage.readFile().then((value) => savedCampaigns = value);

    loading = false;
    notifyListeners();

    print("Read");
  }
}
