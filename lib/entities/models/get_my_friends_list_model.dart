import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_friends_entity.dart';

class MyFriendsScreenModel extends ChangeNotifier {
  int count = 0;
  List userFriendsListInfo = [];
  List userFriendsListInfoAll = [];
  String searchText = '';
  final _searchController = TextEditingController();

  get searchController => _searchController;

  Future getMyFriends(BuildContext context) async {
    final token = context.read<ApiClient>().token;
    var getUserFriends = await http.get(Uri.parse(
        'https://api.vk.com/method/friends.get?v=5.131&access_token=${token}&fields=photo_100,online'));

    var userFriendsMap = jsonDecode(getUserFriends.body);

    var userFriendsResponse = Response.fromJson(userFriendsMap);

    var userFriendsList = FriendsList.fromJson(userFriendsResponse.response);

    userFriendsListInfo =
        userFriendsList.items.map((e) => FriendsListInfo.fromJson(e)).toList();
    userFriendsListInfoAll = userFriendsListInfo;
    count = userFriendsListInfo.length;

    //print(userFriendsListInfo.length);
    notifyListeners();
  }

  Future editSearchText(BuildContext context) async {
    searchText = '';
    userFriendsListInfo = userFriendsListInfoAll;
    searchText = searchController.text;

    List ListInfo = userFriendsListInfo.where((element) {
      String name = element.firstName + ' ' + element.lastName;
      return name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    userFriendsListInfo = ListInfo;

    notifyListeners();
  }
}
