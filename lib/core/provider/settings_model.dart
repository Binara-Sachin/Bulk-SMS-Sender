import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  String userName = "Username";
  String countryCode = "+1";
  int preferredSim = 1;
  bool loading = false;

  void getValues() async {
    loading = true;
    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferredSim = preferences.getInt('counter') ?? 1;
    userName = preferences.getString('userName') ?? "User Name";
    countryCode = preferences.getString('countryCode') ?? "+1";
    loading = false;
    notifyListeners();
  }

  Future<void> setUserName(String un) async {
    userName = un;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('userName', un);
  }

  Future<void> setCountryCode(String cc) async {
    countryCode = cc;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('countryCode', cc);
  }

  Future<void> setPreferredSim(int ps) async {
    preferredSim = ps;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('preferredSim', ps);
  }
}
