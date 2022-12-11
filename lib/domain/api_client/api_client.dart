import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';

class ApiClient extends ChangeNotifier {
  String? _token = '';
  String? get token => _token;
  bool isLogining = false;
  bool isLogin = false;
  var vk;
  int userId = 0;

  void logining() {
    isLogining == true ? isLogining = false : isLogining = true;
    notifyListeners();
  }

  Future<void> login() async {
    vk = VKLogin();
    await vk.initSdk();

    final res = await vk.logIn(scope: [
      /*VKScope.offline,*/
      VKScope.email,
      VKScope.friends,
      VKScope.photos,
    ]);

    if (res.isValue) {
      final VKLoginResult data = res.asValue!.value;

      print('логин $isLogining');
      isLogin = true;

      if (data.isCanceled) {
        print('юзер отменил');
      } else {
        final VKAccessToken? accessToken = data.accessToken;
        _token = accessToken?.token;

        final profile = _token != null ? await vk.getUserProfile() : null;

        print(
            'Hello, ${profile.value.firstName}! You ID: ${profile.value.userId}');
        userId = profile.value.userId;
        //isLogining = false;
        notifyListeners();
      }
    } else {
      final errorRes = res.asError;
      print('Error while log in Ошибка: ${errorRes}');
    }
  }
}
