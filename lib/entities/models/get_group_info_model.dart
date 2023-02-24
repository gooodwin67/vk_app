import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_group_info_entity.dart';

class GetGroupInfoModel extends ChangeNotifier {
  var _groupInfo;

  GroupInfo get groupInfo => _groupInfo;

  Future getGroupInfo(BuildContext context, id) async {
    _groupInfo = null;
    final token = context.read<ApiClient>().token;

    var getGroupInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/groups.getById?v=5.131&access_token=$token&group_id=$id&fields=cover, description'));

    final response = Response.fromJson(jsonDecode(getGroupInfo.body)).response;

    if (response != null) {
      _groupInfo = GroupInfo.fromJson(response[0]);
    }

    notifyListeners();
  }
}
