import 'package:flutter/material.dart';

class BottomMenuModel with ChangeNotifier {
  final List menuScreens = const [
    '/news',
    '/search',
    '/groups',
    '/notifications',
    '/profile',
  ];
  int _activeMenuIndex = 4;
  String _activeWidget = '/profile';

  int get activeMenuIndex => _activeMenuIndex;
  String get activeWidget => _activeWidget;

  Future SetActiveMenu(index) async {
    _activeMenuIndex = index;
    _activeWidget = menuScreens[_activeMenuIndex];

    notifyListeners();
  }
}
