import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';

class CreateSmsProvider extends ChangeNotifier {
  // List<String> _slNumberPrefix = [
  //   "077",
  //   "070",
  //   "071",
  //   "072",
  //   "075",
  //   "076",
  //   "078",
  //   "77",
  //   ""
  // ];

  Duration _duration = Duration(seconds: 30);

  String _newTemplate = "";

  String get newTemplate => _newTemplate;
  List<String> _templates = [];

  void updateTemplate(String template) {
    this._newTemplate = template;
    notifyListeners();
  }

  void commitTemplate() {
    this._templates.add(_newTemplate);
    notifyListeners();
  }

  Duration get duration => _duration;
  int _head = 0;
  String _msg = "";
  List<String> _numbers = [];
  FormState _formState = FormState.INIT;
  CSVState _csvState = CSVState.INIT;
  SliderState _sliderState = SliderState.INIT;

  SliderState get sliderState => _sliderState;
  MessageBoxState _messageBoxState = MessageBoxState.INIT;
  double _lowerTimeDelayLimit = 1.0;
  double _upperTimeDelayLimit = 1.0;

  void valuereSet() {
    _head = 0;
    _msg = "";
    _numbers = [];
    _formState = FormState.INIT;
    _csvState = CSVState.INIT;
    _sliderState = SliderState.INIT;
    _messageBoxState = MessageBoxState.INIT;
    notifyListeners();
  }

  List<String> get numbers => _numbers;

  void setTimeDelayLimits(double lower, double upper) {
    _lowerTimeDelayLimit = lower;
    _upperTimeDelayLimit = upper;
    _sliderState = SliderState.SET;
    notifyListeners();
  }

  void loadFile() async {
    try {
      _csvState = CSVState.LOADING;
      notifyListeners();
      File file = await FilePicker.getFile();
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
      _csvState = CSVState.DONE;
      notifyListeners();
    } catch (e) {
      _csvState = CSVState.ERROR;
      notifyListeners();
    }
  }

  FormState get formState => _formState;

  CSVState get csvState => _csvState;

  MessageBoxState get messageBoxState => _messageBoxState;

  double get lowerTimeDelayLimit => _lowerTimeDelayLimit;

  double get upperTimeDelayLimit => _upperTimeDelayLimit;

  void updateMessage(String m) {
    this._msg = m;
    if (_msg.length > 0) {
      _messageBoxState = MessageBoxState.SET;
    } else {
      _messageBoxState = MessageBoxState.INIT;
    }
    notifyListeners();
  }

  void processSms() async {
    try {
      final sender = SmsSender();
      Random random = Random();

      while (_head < _numbers.length) {
        _duration = Duration(minutes: 1, seconds: 5 + random.nextInt(10 - 5));
        print(_duration.toString());
        notifyListeners();
        await Future.delayed(_duration, () async {
          await sender.sendSms(
            SmsMessage(_numbers[_head].toString(), _msg),
          );
          _head = _head + 1;
          notifyListeners();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  int get head => _head;

  String get msg => _msg;

  List<String> get templates => _templates;
}

enum FormState {
  INIT,
  EDIT,
  ERROR,
  SUCCESS,
}
enum CSVState {
  INIT,
  LOADING,
  ERROR,
  DONE,
}

enum SliderState {
  INIT,
  SET,
}

enum MessageBoxState {
  INIT,
  SET,
}
