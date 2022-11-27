import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FriendsScreenModel extends ChangeNotifier {
  int count = 50;
  Future getUserFriends(token) async {
    var getUserFriends = await http.get(Uri.parse(
        'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}&count=${count}&fields=photo_100'));
    var userFriendsMap = jsonDecode(getUserFriends.body);

    var userFriendsResponse = Response.fromJson(userFriendsMap);

    var userFriendsList = FriendsList.fromJson(userFriendsResponse.response);

    // var userFriendsListInfo =
    //     userFriendsList.items.map((e) => FriendsListInfo.fromJson(e)).toList();

    print(userFriendsList);
    notifyListeners();
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
  final String firstName;

  FriendsListInfo({required this.firstName});

  factory FriendsListInfo.fromJson(Map<String, dynamic> json) {
    return FriendsListInfo(
      firstName: json['first_name'],
    );
  }
}
