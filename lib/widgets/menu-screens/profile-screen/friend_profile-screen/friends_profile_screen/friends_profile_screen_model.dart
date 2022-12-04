import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProfileFriendsScreenModel extends ChangeNotifier {
  int count = 50;
  List userFriendsListInfo = [];
  Future getUserFriends(token, id, deactivated) async {
    if (deactivated == '0') {
      var getUserFriends = await http.get(Uri.parse(
          'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}&user_id=$id&count=${count}&fields=photo_100'));
      var userFriendsMap = jsonDecode(getUserFriends.body);

      var userFriendsResponse = Response.fromJson(userFriendsMap);

      var userFriendsList = FriendsList.fromJson(userFriendsResponse.response);

      userFriendsListInfo = userFriendsList.items
          .map((e) => FriendsListInfo.fromJson(e))
          .toList();

      //print(userFriendsMap);

      notifyListeners();
    } else {
      userFriendsListInfo = [];
    }
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

  FriendsList({required this.items});

  factory FriendsList.fromJson(Map<String, dynamic> json) {
    return FriendsList(
      items: json['items'],
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
