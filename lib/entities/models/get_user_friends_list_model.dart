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
  List userFriendsListInfoAll = [];
  String searchText = '';

  int get count => _count;
  List get userFriendsListInfo => _userFriendsListInfo;

  final _searchController = TextEditingController();
  get searchController => _searchController;

  Future getUserFriends(BuildContext context, id) async {
    _userFriendsListInfo = [];
    userFriendsListInfoAll = [];
    String deactivated = context.read<GetUserInfoModel>().userInfo.deactivated;
    bool canAccess = context.read<GetUserInfoModel>().userInfo.canAccess;
    final token = context.read<ApiClient>().token;

    if (deactivated == '0' && canAccess == true) {
      var getUserFriends = await http.get(Uri.parse(
          'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}&count=$count&user_id=$id&fields=photo_100,online'));

      var userFriendsMap = jsonDecode(getUserFriends.body);

      var userFriendsResponse = Response.fromJson(userFriendsMap);

      var userFriendsList = FriendsList.fromJson(userFriendsResponse.response);

      _userFriendsListInfo = userFriendsList.items
          .map((e) => FriendsListInfo.fromJson(e))
          .toList();
      userFriendsListInfoAll = userFriendsListInfo;
      _count = userFriendsList.count;

      notifyListeners();
    } else {
      _userFriendsListInfo = [];
      userFriendsListInfoAll = [];
      notifyListeners();
    }
  }

  clearSerchField() {
    _searchController.clear();
  }

  Future editSearchText(BuildContext context) async {
    searchText = '';
    _userFriendsListInfo = userFriendsListInfoAll;
    searchText = searchController.text;

    List ListInfo = userFriendsListInfo.where((element) {
      String name = element.firstName + ' ' + element.lastName;
      return name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    _userFriendsListInfo = ListInfo;
    //print(_userFriendsListInfo.length);

    notifyListeners();
  }
}
