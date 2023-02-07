import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_cities_entity.dart';

import 'package:vk_app/entities/get_users_search_entity.dart';

class SearchScreenModel extends ChangeNotifier {
  int _count = 0;
  List _userListInfo = [];
  String _curentValue = '';
  int _offset = 0;
  String _age_from = '';
  String _age_to = '';
  int _sex = 0;
  int _status = 0;

  int _citiesCount = 0;
  List _citiesListInfo = [];
  String _currentCity = '';
  int _currentCityId = 0;

  RangeValues _curentFilterAge = RangeValues(0, 100);

  List _userList = [];
  List get userList => _userList;
  int get sex => _sex;
  int get status => _status;
  int get count => _count;
  RangeValues get curentFilterAge => _curentFilterAge;

  int get citiesCount => _citiesCount;
  List get citiesListInfo => _citiesListInfo;
  String get currentCity => _currentCity;
  int get currentCityId => _currentCityId;

  Future getCitiesSearch(BuildContext context, text, all) async {
    _citiesListInfo = [];
    _citiesCount = 0;
    final token = context.read<ApiClient>().token;
    if (text == '') all = 0;
    var getCities = await http.get(
      Uri.parse(
          'https://api.vk.com/method/database.getCities?v=5.131&access_token=${token}&country_id=1&q=$text&need_all=$all'),
    );
    var getCitiesMap = jsonDecode(getCities.body);
    var getCitiesResponse = ResponseCity.fromJson(getCitiesMap);
    var citiesListMap = CitiesList.fromJson(getCitiesResponse.response);
    _citiesCount = citiesListMap.count;

    _citiesListInfo =
        citiesListMap.items.map((e) => CitiesListInfo.fromJson(e)).toList();

    notifyListeners();
  }

  activeCityInSearch(id, city) {
    _currentCityId = id;
    _currentCity = city;
    notifyListeners();
  }

  Future getUsersSearch(BuildContext context) async {
    final token = context.read<ApiClient>().token;

    var getUsers = await http.get(Uri.parse(
        'https://api.vk.com/method/users.search?v=5.131&access_token=${token}&q=$_curentValue&fields=photo_100,online,bdate&offset=$_offset&age_from=$_age_from&age_to=$_age_to&sex=$_sex&status=$_status&city=$_currentCityId'));

    var usersMap = jsonDecode(getUsers.body);

    var usersResponse = Response.fromJson(usersMap);

    var usersList = UsersList.fromJson(usersResponse.response);

    _userListInfo =
        usersList.items.map((e) => UsersListInfo.fromJson(e)).toList();
    userList.addAll(_userListInfo);
    _count = usersList.count;
    print(_count);
    print('$_offset ----- ------ ---$_count');

    if (_offset + 3 < _count)
      _offset += 20;
    else if (_offset < _count) {
      _offset += _count - _offset;
    } else {
      return;
    }

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

  saveTextFilter(text) {
    _curentValue = text;
  }

  saveFilter() {
    _curentFilterAge.start != 0.0
        ? _age_from = _curentFilterAge.start.toString()
        : _age_from = '';
    _curentFilterAge.end != 100.0
        ? _age_to = _curentFilterAge.start.toString()
        : _age_to = '';

    notifyListeners();
  }

  resetFilter() {
    _age_from = '';
    _age_to = '';
    _sex = 0;
    _status = 0;
    _curentFilterAge = RangeValues(0, 100);
    _currentCityId = 0;
    _currentCity = '';
    notifyListeners();
  }

  clearUsersList() {
    _userList = [];
    _offset = 0;
    notifyListeners();
  }
}
