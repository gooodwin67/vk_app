import 'package:flutter/material.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/main/main_screen_model.dart';

class LoginModel extends ChangeNotifier {
  Future logginIn(context) async {
    Navigator.pushNamed(context, '/main');
    await context.read<ApiClient>().login();
    context
        .read<MainScreenModel>()
        .getUserInfo(context.read<ApiClient>().token);
    notifyListeners();
  }
}
