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
        'https://api.vk.com/method/wall.get?v=5.131&access_token=$token&extended=1&offset=0'));

    var userWallMap = jsonDecode(getUserWall.body);

    var userWallResponse = ResponseWall.fromJson(userWallMap);

    var userWallResponseItemsResponse =
        UserWall.fromJson(userWallResponse.response).items;
    var userWallResponseProfilesResponse =
        UserWall.fromJson(userWallResponse.response).profiles;
    var userWallResponseCountResponse =
        UserWall.fromJson(userWallResponse.response).count;

    var userWallResponseItems =
        userWallResponseItemsResponse.map((e) => UserWallItems.fromJson(e));

    //print(userWallResponseItems);

    List userWallItemsResponse = userWallResponseItems.map((e) {
      var likes = Likes.fromJson(e.likes);
      return ItemInWall(
        fromId: e.fromId,
        date: e.date,
        likes: likes.count,
      );
    }).toList();

    userWallItemsResponse[0].date = 565645;

    print(userWallItemsResponse[0].date);

    //var userWallResponse2 = UserWall.fromJson(userWallResponse.response);
    // List ItemsWallResponse = userWallResponse2.items;

    // List itemsWall = ItemsWallResponse.map((e) {
    //   print(e.runtimeType);
    //   return ItemInWall(
    //     fromId: 0,
    //   );
    // }).toList();

    // allWallCount = userWallResponse2.count;

    //print(itemsWall[0]);

    ///////////////////////////////////////////////////

    // List profilesWallResponse = userWallResponse2.profiles;

    // List profilesWall =
    //     profilesWallResponse.map((e) => UserWallProfiles.fromJson(e)).toList();

    // for (var i in itemsWall) {
    //   for (var j in profilesWall) {
    //     if (i.fromId == j.id) {
    //       var date = DateTime.fromMillisecondsSinceEpoch(i.date * 1000);
    //       initializeDateFormatting('ru_RU', null).then((_) {
    //         var formatDate = DateFormat.yMd().format(date);
    //         itemsInWall.add(ItemInWall(
    //           fromId: i.fromId,
    //           firstName: j.firstName,
    //           lastName: j.lastName,
    //           date: formatDate.replaceAll('/', '.'),
    //           likes: 5,
    //         ));
    //       });
    //     }
    //   }
    // }

    notifyListeners();
  }
}

class ItemInWall {
  int fromId;
  // String lastName = 'lastName';
  // String firstName = 'firstName';
  int date;
  int likes;
  ItemInWall({
    required this.fromId,
    // required this.firstName,
    // required this.lastName,
    required this.date,
    required this.likes,
  });
}
