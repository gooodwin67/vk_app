import 'package:flutter/material.dart';
import 'package:vk_app/widgets/menu-screens/messages-screen/messages-screen.dart';
import 'package:vk_app/widgets/menu-screens/news-screen/news-screen.dart';
import 'package:vk_app/widgets/menu-screens/notifications-screen/notifications-screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/profile-screen.dart';
import 'package:vk_app/widgets/menu-screens/search-screen/search-screen.dart';

class MainScreenModel with ChangeNotifier {
  final List menuScreens = const [
    NewsScreenWidget(),
    SearchScreenWidget(),
    MessagesScreenWidget(),
    NotificationsScreenWidget(),
    ProfileScreenWidget()
  ];
  int _activeMenuIndex = 0;
  Widget _activeWidget = NewsScreenWidget();

  int get activeMenuIndex => _activeMenuIndex;
  Widget get activeWidget => _activeWidget;

  void SetActiveMenu(index) {
    _activeMenuIndex = index;
    _activeWidget = menuScreens[_activeMenuIndex];
    notifyListeners();
  }
}
