import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:flutter/material.dart';

class CampaignsModel extends ChangeNotifier {
  List<Campaign> savedCampaigns;
  DataState dataState = DataState.Null;

  void testCampaign() {
    savedCampaigns = testCampaigns;
    notifyListeners();
  }

  // Future<Database> _openCampaignsDatabase() async {
  //   return openDatabase(
  //     join(await getDatabasesPath(), 'doggie_database.db'),
  //     onCreate: (db, version) {
  //       return db.execute(
  //         "CREATE TABLE dogs(id INTEGER PRIMARY KEY, campaignName TEXT, age INTEGER)",
  //       );
  //     },
  //     version: 1,
  //   );
  // }

  // void loadData() async {
  //   final Database db = await _openCampaignsDatabase();
  //   final List<Map<String, dynamic>> maps = await db.query('campaigns');

  //   savedCampaigns = List.generate(
  //     maps.length,
  //     (i) {
  //       return Campaign(
  //         id: maps[i]['id'],
  //         campaignName: maps[i]['campaignName'],
  //         msg: maps[i]['msg'],
  //         delayDuration: maps[i]['delayDuration'],
  //         addresses: maps[i]['addresses'],
  //       );
  //     },
  //   );
  // }

  void saveCampaign(Campaign campaign) async {
    // final Database db = await _openCampaignsDatabase();

    // await db.insert(
    //   'campaigns',
    //   campaign.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );

    savedCampaigns.add(campaign);
    notifyListeners();
  }

  // void updateCampaign(Campaign campaign) async {
  //   final Database db = await _openCampaignsDatabase();

  //   await db.update(
  //     'campaign',
  //     campaign.toMap(),
  //     where: "id = ?",
  //     whereArgs: [campaign.id],
  //   );
  // }

  void deleteCampaign(Campaign campaign) async {
    // final Database db = await _openCampaignsDatabase();

    // await db.delete(
    //   'campaign',
    //   where: "id = ?",
    //   whereArgs: [campaign.id],
    // );

    savedCampaigns.remove(campaign);
    notifyListeners();
  }
}

enum DataState {
  Null,
  Loading,
  Complete,
}

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
  ),
  Campaign(
    id: 1,
    campaignName: "Test Campaign 02",
    msg: "Test Message 2",
    addresses: _testingMobileNumbers,
    delayDuration: Duration(seconds: 10),
  ),
  Campaign(
    id: 2,
    campaignName: "Test Campaign 03",
    msg: "Test Message 3",
    addresses: _testingMobileNumbers,
    delayDuration: Duration(seconds: 10),
  ),
  Campaign(
    id: 3,
    campaignName: "Test Campaign 04",
    msg: "Test Message 4",
    addresses: _testingMobileNumbers,
    delayDuration: Duration(seconds: 10),
  ),
];
