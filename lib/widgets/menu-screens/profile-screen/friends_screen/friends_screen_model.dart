import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class FriendsScreenModel extends ChangeNotifier {
  bool isLoadingProgress = false;
  int count = 20;
  List userFriendsListInfo = [];
  int offset = 0;
  var allToken;
  int allFriends = 0;
  Future getUserFriends(token) async {
    var getUserFriends = await http.get(Uri.parse(
        'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}&count=${count}&offset=$offset&fields=photo_100'));
    allToken = token;
    var userFriendsMap = jsonDecode(getUserFriends.body);

    var userFriendsResponse = Response.fromJson(userFriendsMap);

    var userFriendsList = FriendsList.fromJson(userFriendsResponse.response);
    allFriends = userFriendsList.count;

    var userFriendsListInfo1 =
        userFriendsList.items.map((e) => FriendsListInfo.fromJson(e)).toList();
    userFriendsListInfo.addAll(userFriendsListInfo1);

    //print(userFriendsListInfo[0]);
    notifyListeners();
  }

  void showFriendIndex(int index) {
    if (index < userFriendsListInfo.length - 1 ||
        index == allFriends - 1 ||
        isLoadingProgress) return;
    isLoadingProgress = true;

    offset = offset + count;
    getUserFriends(allToken);
    isLoadingProgress = false;
  }
}

class Response {
  final Map<String, dynamic> response;

  Response({required this.response});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      response: json['response'],
    );
  }
}

class FriendsList {
  final List items;
  final int count;

  FriendsList({required this.items, required this.count});

  factory FriendsList.fromJson(Map<String, dynamic> json) {
    return FriendsList(
      items: json['items'],
      count: json['count'],
    );
  }
}

class FriendsListInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String photo;

  FriendsListInfo(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.photo});

  factory FriendsListInfo.fromJson(Map<String, dynamic> json) {
    return FriendsListInfo(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photo: json['photo_100'],
    );
  }
}
