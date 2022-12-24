import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_wall_entity.dart';
import 'package:intl/date_symbol_data_local.dart';

class GetMyWallModel extends ChangeNotifier {
  int allWallCount = 0;
  List itemsWall = [];

  List itemsInWall = [];

  Future getMyWall(BuildContext context) async {
    final token = context.read<ApiClient>().token;

    var getUserWall = await http.get(Uri.parse(
        'https://api.vk.com/method/wall.get?v=5.131&access_token=$token&extended=1&offset=200'));

    var userWallMap = jsonDecode(getUserWall.body);
    var userWallResponse = ResponseWall.fromJson(userWallMap);

    var userWallResponse2 = UserWall.fromJson(userWallResponse.response);
    List ItemsWallResponse = userWallResponse2.items;
    allWallCount = userWallResponse2.count;

    itemsWall =
        ItemsWallResponse.map((e) => UserWallItems.fromJson(e)).toList();

    ///////////////////////////////////////////////////

    List profilesWallResponse = userWallResponse2.profiles;

    List profilesWall =
        profilesWallResponse.map((e) => UserWallProfiles.fromJson(e)).toList();

    Future dateMod(date) async {
      var a = DateTime.fromMillisecondsSinceEpoch(date * 1000);
      await initializeDateFormatting('ru_RU', null).then((_) {
        var format = DateFormat.yMd().format(a);
        //print(format);
        return format;
      });
    }

    //print(dateMod(1272717240));

    for (var i in itemsWall) {
      for (var j in profilesWall) {
        if (i.fromId == j.id) {
          var date = DateTime.fromMillisecondsSinceEpoch(i.date * 1000);
          initializeDateFormatting('ru_RU', null).then((_) {
            var formatDate = DateFormat.yMd().format(date);
            itemsInWall.add(ItemInWall(
              fromId: i.fromId,
              firstName: j.firstName,
              lastName: j.lastName,
              date: formatDate,
            ));
          });
        }
      }
    }

    //var date = DateTime.fromMillisecondsSinceEpoch(1272717240 * 1000);

    //print(date);

    notifyListeners();
  }
}

class ItemInWall {
  int fromId;
  String lastName;
  String firstName;
  String date;
  ItemInWall({
    required this.fromId,
    required this.firstName,
    required this.lastName,
    required this.date,
  });
}
