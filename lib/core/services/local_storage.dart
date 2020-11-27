import 'dart:io';

import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/campaigns.txt');
  }

  Future<List<Campaign>> readFile() async {
    List<Campaign> campaigns = [];
    try {
      final file = await _localFile;

      List<String> contents = await file.readAsLines();
      print(contents.length);
      // print(contents.toString());

      if (contents.isNotEmpty) {
        for (var i = 0; i < contents.length; i += 6) {
          print("i = " + i.toString());

          int id = int.parse(contents[i]);
          print(id);

          String name = contents[i + 1];
          print(name);

          String message = contents[i + 2];
          print(message);

          Duration delay = Duration(seconds: int.parse(contents[i + 3]));
          print(delay.toString());

          List<String> addresses = contents[i + 4].split(',').toList();
          print(addresses.toString());

          DateTime last = DateTime.parse(contents[i + 5]);
          print(last.toString());

          campaigns.add(
            Campaign(
              id: id,
              campaignName: name,
              msg: message,
              delayDuration: delay,
              addresses: addresses,
              lastRun: last,
            ),
          );
        }
      }

      return campaigns;
    } catch (e) {
      return [];
    }
  }

  Future<File> writeFile(List<Campaign> campaigns) async {
    final file = await _localFile;

    String writeData = "";
    for (var c in campaigns) {
      writeData += c.id.toString() + "\n";
      writeData += c.campaignName + "\n";
      writeData += c.msg + "\n";
      writeData += c.delayDuration.inSeconds.toString() + "\n";
      writeData += c.addresses.join(",") + "\n";
      writeData += c.lastRun.toString() + "\n";
    }

    return file.writeAsString(writeData);
  }
}
