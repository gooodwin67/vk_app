import 'package:flutter/material.dart';

class AllRoutesModel extends ChangeNotifier {
  String login = '/login';
  String main = '/main';
  String myFriends = '/main/friends';
  String userProfile = '/main/friends/user-profile';

  String thisRoute = '/login';
  bool is404 = false;

  int userId = 0;

  goToRoute(route, id) {
    thisRoute = route;
    userId = id;
    notifyListeners();
  }
}
