import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_wall_entity.dart';

class GetMywallModel extends ChangeNotifier {
  int allWallCount = 0;

  Future getMyWall(BuildContext context) async {
    final token = context.read<ApiClient>().token;

    var getUserWall = await http.get(Uri.parse(
        'https://api.vk.com/method/wall.get?v=5.131&access_token=$token'));

    var userWallMap = jsonDecode(getUserWall.body);
    var userWallResponse = ResponseWall.fromJson(userWallMap);

    var userWallResponse2 = UserWall.fromJson(userWallResponse.response);
    List ItemsWallResponse = userWallResponse2.items;

    List ItemsWall =
        ItemsWallResponse.map((e) => UserWallItems.fromJson(e)).toList();

    allWallCount = userWallResponse2.count;

    print('wallcount ${ItemsWall[0].fromId}');

    // _userInfo = UserInfo.fromJson(userInfoResponse.response.first);

    // var _cityResponse = City.fromJson(userInfo.city);
    // _city = _cityResponse.title;

    // var _coverResponse = Cover.fromJson(userInfo.cover);
    // if (_coverResponse.listCovers.length > 0) {
    //   _isCover = true;
    //   var coverUrlResponse = CoverUrl.fromJson(_coverResponse.listCovers[0]);
    //   _coverUrl = coverUrlResponse.url;
    //   //print(coverUrl.url);
    // }

    notifyListeners();
  }
}
