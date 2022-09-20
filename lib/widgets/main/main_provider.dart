import 'package:flutter/Material.dart';

class MainProvider extends ChangeNotifier {
  int _indexScreen = 0;

  int get indexScreen => _indexScreen;

  changeScreen(index) {
    _indexScreen = index;
    notifyListeners();
  }
}
