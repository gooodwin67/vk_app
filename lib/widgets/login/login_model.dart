import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_vk/flutter_login_vk.dart';

class LoginModel extends ChangeNotifier {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String _textInvalidLogin = '';
  String get textInvalidLogin => _textInvalidLogin;

  bool _loginActive = false;
  bool get canStartLogin => !_loginActive;

  Future<void> login(BuildContext context) async {
    final vk = VKLogin();
    await vk.initSdk();
    final res = await vk.logIn(scope: [
      VKScope.friends,
    ]);

    if (res.isValue) {
      // There is no error, but we don't know yet
      // if user loggen in or not.
      // You should check isCanceled
      final VKLoginResult data = res.asValue!.value;
      print('логин');

      if (data.isCanceled) {
        // User cancel log in
        print('юзер отменил');
      } else {
        // Logged in
        // Send access token to server for validation and auth
        final VKAccessToken? accessToken = data.accessToken;
        final token = accessToken?.token;

        var friends = await http.get(Uri.parse(
            'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}'));
        var friendsMap = jsonDecode(friends.body);
        //var friendsCount = friendsMap.count;
        //String friendsList = friendsMap.items;
        //print(friendsMap);

        var friendsRes = FriendsResponse.fromJson(friendsMap);
        //print(friendsRes.response);

        var friendsResMap = jsonEncode(friendsRes.response);
        var friendsResMap1 = jsonDecode(friendsResMap);

        var friendsList = FriendsList.fromJson(friendsResMap1);
        //print(friendsList.items);

        var response = await http.get(Uri.parse(
            'https://api.vk.com/method/users.get?user_ids=569374, 606812&fields=photo_100&v=5.131&access_token=${token}'));
        var responseMap = jsonDecode(response.body);
        //print(responseMap);
      }
    } else {
      // Log in failed
      final errorRes = res.asError;
      print('Error while log in Ошибка: ${errorRes}');
    }
  }
}

class LoginProvider extends InheritedNotifier {
  LoginProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          child: child,
          notifier: model,
        );

  final LoginModel model;

  static LoginProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LoginProvider>();
  }
}

class FriendsResponse {
  final Map response;

  FriendsResponse({required this.response});

  factory FriendsResponse.fromJson(Map<String, dynamic> json) {
    return FriendsResponse(response: json['response']);
  }
}

class FriendsList {
  final int count;
  final List items;

  FriendsList({required this.count, required this.items});

  factory FriendsList.fromJson(Map<String, dynamic> json) {
    return FriendsList(
      count: json['count'],
      items: json['items'],
    );
  }
}
