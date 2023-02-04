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
  String _age_from = '';
  String _age_to = '';
  int _sex = 0;
  int _status = 0;

  RangeValues _curentFilterAge = RangeValues(0, 100);

  List _userList = [];
  List get userList => _userList;
  int get sex => _sex;
  int get status => _status;
  RangeValues get curentFilterAge => _curentFilterAge;

  Future getUsersSearch(BuildContext context, text) async {
    final token = context.read<ApiClient>().token;
    if (text != '') _curentValue = text;

    var getUsers = await http.get(Uri.parse(
        'https://api.vk.com/method/users.search?v=5.131&access_token=${token}&q=$_curentValue&fields=photo_100,online,bdate&offset=$_offset&age_from=$_age_from&age_to=$_age_to&sex=$_sex&status=$_status'));

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

  changeFilterAge(value) {
    _curentFilterAge = value;
    notifyListeners();
  }

  changeFilterSex(value) {
    _sex = value;
    notifyListeners();
  }

  changeFilterStatus(value) {
    _status = value;
    notifyListeners();
  }

  saveFilter() {
    _age_from = _curentFilterAge.start.toString();
    _age_to = _curentFilterAge.end.toString();
    notifyListeners();
  }

  resetFilter() {
    _age_from = '';
    _age_to = '';
    _sex = 0;
    _status = 0;
    _curentFilterAge = RangeValues(0, 100);
    notifyListeners();
  }

  clearUsersList() {
    _userList = [];
    _offset = 0;
    notifyListeners();
  }
}
