import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_friends_entity.dart';

class FriendsScreenModel extends ChangeNotifier {
  int count = 0;
  List userFriendsListInfo = [];

  Future getUserFriends(BuildContext context, id) async {
    final token = context.read<ApiClient>().token;
    var getUserFriends = await http.get(Uri.parse(
        'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}&user_id=$id&fields=photo_100'));

    var userFriendsMap = jsonDecode(getUserFriends.body);

    var userFriendsResponse = Response.fromJson(userFriendsMap);

    var userFriendsList = FriendsList.fromJson(userFriendsResponse.response);

    userFriendsListInfo =
        userFriendsList.items.map((e) => FriendsListInfo.fromJson(e)).toList();
    count = userFriendsListInfo.length;

    //print(userFriendsListInfo.length);
    notifyListeners();
  }
}
