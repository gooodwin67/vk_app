import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MainScreenModel extends ChangeNotifier {
  Widget _mainScreen = CircularProgressIndicator();
  String? _userName = '1';
  String? get userName => _userName;
  Widget get mainScreen => _mainScreen;

  Future getUserInfo(token) async {
    var getUserInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=${token}'));

    var userInfoMap = jsonDecode(getUserInfo.body);
    var userInfoResponse = Response.fromJson(userInfoMap);
    var userInfoResponseMap = jsonEncode(userInfoResponse.response);
    var userInfoResponseMap2 = jsonDecode(userInfoResponseMap);

    var userInfo = UserInfo.fromJson(userInfoResponseMap2[0]);
    _userName = userInfo.firstName;
    //_mainScreen = Text(_userName.toString());
    //print(userInfo.firstName);
    print(_userName);
    notifyListeners();
  }
}

class Response {
  final List response;

  Response({required this.response});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      response: json['response'],
    );
  }
}

class UserInfo {
  final String firstName;

  UserInfo({required this.firstName});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['first_name'],
    );
  }
}
