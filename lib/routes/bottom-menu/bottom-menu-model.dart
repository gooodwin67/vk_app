import 'package:flutter/material.dart';

class BottomMenuModel with ChangeNotifier {
  final List menuScreens = const [
    '/news',
    '/search',
    '/messages',
    '/notifications',
    '/profile',
  ];
  int _activeMenuIndex = 0;
  String _activeWidget = '/news';

  int get activeMenuIndex => _activeMenuIndex;
  String get activeWidget => _activeWidget;

  Future SetActiveMenu(index) async {
    _activeMenuIndex = index;
    _activeWidget = menuScreens[_activeMenuIndex];
    print(_activeWidget);
    notifyListeners();
  }
}
