import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_groups_entity.dart';

class GetGroupsModel extends ChangeNotifier {
  List _items = [];
  int _countGroups = 0;

  List get items => _items;
  int get countGroups => _countGroups;

  Future getGroups(BuildContext context, text, offset, count) async {
    final token = context.read<ApiClient>().token;

    var getGroups = await http.get(Uri.parse(
        'https://api.vk.com/method/groups.search?v=5.131&access_token=$token&q=$text&offset=$offset&count=$count'));

    final response = Response.fromJson(jsonDecode(getGroups.body)).response;
    if (response != null) {
      _countGroups = response['count'];
      _items = response['items'].map((e) => Item.fromJson(e)).toList();
    }

    notifyListeners();
  }
}
