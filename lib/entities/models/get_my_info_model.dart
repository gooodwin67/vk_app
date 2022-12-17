import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_info_entity.dart';

class GetMyInfoModel extends ChangeNotifier {
  UserInfo? _userInfo;
  String _city = 'city';
  String _coverUrl = '';
  bool _isCover = false;

  get userInfo => _userInfo;
  get city => _city;
  get coverUrl => _coverUrl;
  get isCover => _isCover;

  Future getMyInfo(BuildContext context) async {
    final token = context.read<ApiClient>().token;

    var getUserInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=$token&fields=city,photo_100,online,cover'));

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

    notifyListeners();
  }
}
