import 'package:flutter/material.dart';

class ControllerHours extends ChangeNotifier {
  double? hourSelected;

  void chandeHours(double h) {
    hourSelected = h;
    notifyListeners();
  }
}
