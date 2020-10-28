import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

Future<List<String>> importCSVFile() async {
  List<String> _numbers = [];

  try {
    print("CSV Importer - start");
    File file = await FilePicker.getFile();
    print("CSV Importer path -" + file.path);
    final input = file.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter())
        .toList();
    for (var field in fields) {
      String value = field[0].toString();
      value = "+" + value;
      _numbers.add(value);
    }
  } catch (e) {
    print(e);
  }
  print("CSV Importer numbers -" + _numbers.toString());
  return _numbers;
}
