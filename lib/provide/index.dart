import 'package:flutter/material.dart';

class IndexProvide with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int val) {
    this.currentIndex = val;
    notifyListeners();
  }
}
