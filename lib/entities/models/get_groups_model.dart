import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_groups_entity.dart';

class GetGroupsModel extends ChangeNotifier {
  List _items = [];
  int _countGroups = 0;
  int _offset = 0;
  String _searchText = 'а';

  List get items => _items;
  int get countGroups => _countGroups;

  Future getGroups(BuildContext context, count) async {
    final token = context.read<ApiClient>().token;

    var getGroups = await http.get(Uri.parse(
        'https://api.vk.com/method/groups.search?v=5.131&access_token=$token&q=$_searchText&offset=$_offset&count=$count'));

    final response = Response.fromJson(jsonDecode(getGroups.body)).response;
    if (response != null) {
      _countGroups = response['count'];
      _items.addAll(response['items'].map((e) => Item.fromJson(e)).toList());

      _offset += 20;
    }

    notifyListeners();
  }

  updateSearchText(text) {
    _searchText = text;
  }

  resetItems() {
    _items = [];
    _offset = 0;
  }
}
