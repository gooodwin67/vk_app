//51419080
//vk1.a.K3ej-wtcK-MRy6A250QvBg9NCK4GUga5SWrEefb0KzYjPgyIJ8_58Y1eouNJ-GOTNORLmxmAa6Od-M-5lx6aHztd_kll3qfANCx7Y_s-yUgsUkwj0owhV9iugP3B1uo23Y36fss8Ecgrc6b9ZESpVPvjmvihBZhjvylb0y3YKh4ZCxCHtQAoyycPFjZIaFkv

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Future<void> login() async {
    final vk = VKLogin();
    await vk.initSdk();

    final res = await vk.logIn(scope: [
      VKScope.friends,
    ]);

    if (res.isValue) {
      final VKLoginResult data = res.asValue!.value;
      print('логин');

      if (data.isCanceled) {
        // User cancel log in
        print('юзер отменил');
      } else {
        final VKAccessToken? accessToken = data.accessToken;
        final token = accessToken?.token;
        final prefs = await SharedPreferences.getInstance();
        //await prefs.remove('token');
        await prefs.setString('token', token!);
      }
    } else {
      final errorRes = res.asError;
      print('Error while log in Ошибка: ${errorRes}');
    }
  }

  Future<UserInfo> getInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    var userInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=${token}'));
    var userInfoMap = jsonDecode(userInfo.body);

    var userInfoResponse = AllResponse.fromJson(userInfoMap);
    var userInfoResponseMap = jsonEncode(userInfoResponse.response);
    var userInfoResponseMap2 = jsonDecode(userInfoResponseMap);
    var userInfoRes = UserInfo.fromJson(userInfoResponseMap2[0]);
    return userInfoRes;
    //print(userInfoRes.id);
  }
}

class AllResponse {
  final List response;

  AllResponse({required this.response});

  factory AllResponse.fromJson(Map<String, dynamic> json) {
    return AllResponse(response: json['response']);
  }
}

class UserInfo {
  final int id;
  final String firstName;

  UserInfo({required this.id, required this.firstName});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      firstName: json['firstName'],
    );
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
