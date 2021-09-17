import 'package:flutter/material.dart';

class CreditCalculator extends ChangeNotifier {
  final List<bool> _termsValue = [false, false, false, false];
  final List<String> _buttonList = ['1 luna', '3 luni', '6 luni', '12 luni'];
  double _credit = 100;
  set credit(double value) {
    _credit = value;
    notifyListeners();
  }

  double get credit => _credit;

  String _period = '0 luni';
  set period(String value) {
    _period = value;
    notifyListeners();
  }

  String get period => _period;

  double interest = 0;
  double sum = 100;

  List<bool> get terms => _termsValue;
  List<String> get buttons => _buttonList;
  void getTotalSum() {
    if (_period.isNotEmpty) {
      sum = _credit + (_credit * .01 * int.parse(_period.split(' ').first));
      notifyListeners();
    } else {
      sum = _credit + _credit * .01;
      notifyListeners();
    }
  }

  void getMonthInterest() {
    if (_period.isNotEmpty) {
      interest = _credit / int.parse(_period.split(' ').first) + _credit * .01;
      notifyListeners();
    } else {
      interest = _credit / 1 + _credit * .01;
      notifyListeners();
    }
  }
}
