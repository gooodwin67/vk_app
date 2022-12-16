import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_friends_entity.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';

class FriendsScreenModel extends ChangeNotifier {
  int _count = 0;
  List _userFriendsListInfo = [];

  int get count => _count;
  List get userFriendsListInfo => _userFriendsListInfo;

  Future getUserFriends(BuildContext context, id) async {
    _userFriendsListInfo = [];
    String deactivated = context.read<GetUserInfoModel>().userInfo.deactivated;
    bool canAccess = context.read<GetUserInfoModel>().userInfo.canAccess;
    final token = context.read<ApiClient>().token;

    if (deactivated == '0' && canAccess == true) {
      var getUserFriends = await http.get(Uri.parse(
          'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}&user_id=$id&fields=photo_100'));

      var userFriendsMap = jsonDecode(getUserFriends.body);

      var userFriendsResponse = Response.fromJson(userFriendsMap);

      var userFriendsList = FriendsList.fromJson(userFriendsResponse.response);

      _userFriendsListInfo = userFriendsList.items
          .map((e) => FriendsListInfo.fromJson(e))
          .toList();
      _count = userFriendsListInfo.length;
      //print(count);
      //print(userFriendsListInfo.length);
      notifyListeners();
    } else {
      _userFriendsListInfo = [];
      notifyListeners();
    }
  }
}
