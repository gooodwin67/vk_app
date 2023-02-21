import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class GetGroupsModel extends ChangeNotifier {
  Future getGroups(BuildContext context, text, offset, count) async {
    final token = context.read<ApiClient>().token;

    var getGroups = await http.get(Uri.parse(
        'https://api.vk.com/method/groups.search?v=5.131&access_token=$token&q=$text&offset=$offset&count=$count'));

    var aa = getGroups.body;
  }
}
