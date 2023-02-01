import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

import 'package:vk_app/entities/get_users_search_entity.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';

class SearchScreenModel extends ChangeNotifier {
  int _count = 0;
  List _userListInfo = [];
  String _curentValue = '';
  int _offset = 0;

  List _userList = [];
  List get userList => _userList;

  Future getUsersSearch(BuildContext context, text) async {
    final token = context.read<ApiClient>().token;
    if (text != '') _curentValue = text;
    print(_curentValue);

    var getUsers = await http.get(Uri.parse(
        'https://api.vk.com/method/users.search?v=5.131&access_token=${token}&q=$_curentValue&fields=photo_100,online&offset=$_offset'));

    var usersMap = jsonDecode(getUsers.body);

    var usersResponse = Response.fromJson(usersMap);

    var usersList = UsersList.fromJson(usersResponse.response);

    _userListInfo =
        usersList.items.map((e) => UsersListInfo.fromJson(e)).toList();

    userList.addAll(_userListInfo);

    _count = usersList.count;

    if (_offset + 20 < _count) _offset += 20;

    notifyListeners();
  }

  clearUsersList() {
    _userList = [];
    _offset = 0;
  }
}
