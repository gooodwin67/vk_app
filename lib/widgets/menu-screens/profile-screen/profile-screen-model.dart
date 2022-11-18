import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProfileScreenModel extends ChangeNotifier {
  Widget _mainScreen = CircularProgressIndicator();
  String? _userName = '1';
  String? get userName => _userName;
  Widget get mainScreen => _mainScreen;

  Future getUserInfo(token) async {
    var getUserInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=${token}&fields=city,bdate'));

    var userInfoMap = jsonDecode(getUserInfo.body);
    var userInfoResponse = Response.fromJson(userInfoMap);

    var userInfo = UserInfo.fromJson(userInfoResponse.response.first);
    _userName = userInfo.firstName;

    //print(userInfoResponse.response);
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
