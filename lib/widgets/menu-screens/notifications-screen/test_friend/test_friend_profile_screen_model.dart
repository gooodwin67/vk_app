import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_info_entity.dart';

class TestFriensProfiledModel extends ChangeNotifier {
  UserInfo? _userInfo;

  get userInfo => _userInfo;

  Future getUserInfo(BuildContext context, id) async {
    final token = context.read<ApiClient>().token;

    var getUserInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=$token&user_ids=$id&fields=city,photo_100,online'));

    var userInfoMap = jsonDecode(getUserInfo.body);
    var userInfoResponse = ResponseInfo.fromJson(userInfoMap);

    _userInfo = UserInfo.fromJson(userInfoResponse.response.first);

    notifyListeners();
  }
}
