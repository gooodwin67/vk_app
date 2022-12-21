import 'package:flutter/material.dart';
import 'package:vk_app/widgets/menu-screens/messages-screen/messages-screen.dart';
import 'package:vk_app/widgets/menu-screens/news-screen/news-screen.dart';
import 'package:vk_app/widgets/menu-screens/notifications-screen/notifications-screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/profile-screen.dart';
import 'package:vk_app/widgets/menu-screens/search-screen/search-screen.dart';

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
