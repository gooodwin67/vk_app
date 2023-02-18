import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_info_entity.dart';

class GetUserInfoModel extends ChangeNotifier {
  UserInfo? _userInfo;
  String _city = 'city';
  String _coverUrl = '';
  bool _isCover = false;
  String _lastSeenTime = '';

  get userInfo => _userInfo;
  get city => _city;
  get coverUrl => _coverUrl;
  get isCover => _isCover;
  get lastSeenTime => _lastSeenTime;

  Future getUserInfo(BuildContext context, id) async {
    final token = context.read<ApiClient>().token;
    _isCover = false;

    var getUserInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=$token&user_ids=$id&fields=city,photo_100,online,cover,domain,bdate,relation,followers_count, sex, counters, last_seen'));

    var userInfoMap = jsonDecode(getUserInfo.body);
    var userInfoResponse = ResponseInfo.fromJson(userInfoMap);

    _userInfo = UserInfo.fromJson(userInfoResponse.response.first);

    var _cityResponse = City.fromJson(userInfo.city);
    _city = _cityResponse.title;

    var _coverResponse = Cover.fromJson(userInfo.cover);

    if (_coverResponse.listCovers.length > 0) {
      _isCover = true;
      var coverUrlResponse = CoverUrl.fromJson(_coverResponse.listCovers[0]);
      _coverUrl = coverUrlResponse.url;
      //print(coverUrl.url);
    }
    var _lastSeen = LastSeen.fromJson(_userInfo!.lastSeen);
    int _now = (DateTime.now().millisecondsSinceEpoch / 1000).round();

    var _lastSeenTimeInt = (_now - _lastSeen.time);
    if (_lastSeenTimeInt >= 2629746) {
      _lastSeenTime = '${(_lastSeenTimeInt / 2629746).round()} мес';
    } else if (_lastSeenTimeInt >= 604800) {
      _lastSeenTime = '${(_lastSeenTimeInt / 604800).round()} н';
    } else if (_lastSeenTimeInt >= 86400) {
      _lastSeenTime = '${(_lastSeenTimeInt / 86400).round()} д';
    } else if (_lastSeenTimeInt >= 3600) {
      _lastSeenTime = '${(_lastSeenTimeInt / 3600).round()} ч';
    } else if (_lastSeenTimeInt >= 60) {
      _lastSeenTime = '${(_lastSeenTimeInt / 60).round()} мин';
    }

    switch (_userInfo!.relation) {
      case 1:
        _userInfo!.sex == 1
            ? _userInfo!.relationString = 'не замужем'
            : _userInfo!.sex == 2
                ? _userInfo!.relationString = 'не женат'
                : 'не замужем/не женат';
        break;
      case 2:
        _userInfo!.sex == 1
            ? _userInfo!.relationString = 'есть друг'
            : _userInfo!.sex == 2
                ? _userInfo!.relationString = 'есть подруга'
                : 'есть друг/есть подруга';
        break;
      case 3:
        _userInfo!.sex == 1
            ? _userInfo!.relationString = 'помолвлена'
            : _userInfo!.sex == 2
                ? _userInfo!.relationString = 'помолвлен'
                : 'помолвлен/помолвлена';
        break;
      case 4:
        _userInfo!.sex == 1
            ? _userInfo!.relationString = 'замужем'
            : _userInfo!.sex == 2
                ? _userInfo!.relationString = 'женат'
                : 'замужем/женат';
        break;
      case 5:
        _userInfo!.relationString = 'всё сложно';
        break;
      case 6:
        _userInfo!.relationString = 'в активном поиске';
        break;
      case 7:
        _userInfo!.sex == 1
            ? _userInfo!.relationString = 'влюблена'
            : _userInfo!.sex == 2
                ? _userInfo!.relationString = 'влюблен'
                : 'влюблен/влюблена';
        break;
      case 8:
        _userInfo!.relationString = 'в гражданском браке';
        break;
      case 0:
        _userInfo!.relationString = '';
        break;
    }

    notifyListeners();
  }
}
