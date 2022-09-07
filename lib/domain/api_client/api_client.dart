//51419080
//vk1.a.K3ej-wtcK-MRy6A250QvBg9NCK4GUga5SWrEefb0KzYjPgyIJ8_58Y1eouNJ-GOTNORLmxmAa6Od-M-5lx6aHztd_kll3qfANCx7Y_s-yUgsUkwj0owhV9iugP3B1uo23Y36fss8Ecgrc6b9ZESpVPvjmvihBZhjvylb0y3YKh4ZCxCHtQAoyycPFjZIaFkv

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'dart:convert';

class ApiClient {
  String resss = '';
  Future<void> login() async {
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

        var userInfo = await http.get(Uri.parse(
            'https://api.vk.com/method/users.get?v=5.131&access_token=${token}'));
        var userInfoMap = jsonDecode(userInfo.body);
        resss = userInfoMap['response'][0]['id'].toString();
        //print(userInfoMap['response'][0]['id']);

        var friends = await http.get(Uri.parse(
            'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}'));
        var friendsMap = jsonDecode(friends.body);

        var friendsRes = FriendsResponse.fromJson(friendsMap);

        var friendsResMap = jsonEncode(friendsRes.response);
        var friendsResMap1 = jsonDecode(friendsResMap);

        var friendsList = FriendsList.fromJson(friendsResMap1);

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
