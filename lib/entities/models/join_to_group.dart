import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_groups_entity.dart';

class JoinToGroupModel extends ChangeNotifier {
  Future joinToGroup(BuildContext context, id) async {
    final token = context.read<ApiClient>().token;

    var joinGroup = await http.get(Uri.parse(
        'https://api.vk.com/method/groups.join?v=5.131&access_token=$token&group_id=$id'));

    final response = jsonDecode(joinGroup.body);

    notifyListeners();
  }
}

class LeaveFromGroupModel extends ChangeNotifier {
  Future leaveFromGroup(BuildContext context, id) async {
    final token = context.read<ApiClient>().token;

    var leaveGroup = await http.get(Uri.parse(
        'https://api.vk.com/method/groups.leave?v=5.131&access_token=$token&group_id=$id'));

    final response = jsonDecode(leaveGroup.body);

    notifyListeners();
  }
}
