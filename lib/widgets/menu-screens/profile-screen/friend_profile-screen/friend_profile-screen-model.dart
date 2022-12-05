import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FriendProfileScreenModel extends ChangeNotifier {
  String _deactivated = '0';
  bool _canAccess = true;
  String _firstName = 'firstname';
  String _secondName = 'lastname';
  String _city = 'city';
  String _photo = 'assets/images/no-avatar.png';
  int _online = 0;
  List _urls = [];

  String get deactivated => _deactivated;
  bool get canAccess => _canAccess;
  String get firstName => _firstName;
  String get secondName => _secondName;
  String get city => _city;
  String get photo => _photo;
  List get urls => _urls;

  BoxDecoration get online {
    if (_online == 0) {
      return BoxDecoration(
        border: Border.all(
          width: 0,
          color: Colors.transparent,
        ),
      );
    } else {
      return BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        color: Colors.green,
        borderRadius: BorderRadius.circular(50),
      );
    }
  }

  Future getUserInfo(token, id) async {
    var getUserInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=$token&user_ids=$id&fields=city,photo_100,online'));

    var userInfoMap = jsonDecode(getUserInfo.body);
    var userInfoResponse = ResponseInfo.fromJson(userInfoMap);

    var userInfo = UserInfo.fromJson(userInfoResponse.response.first);

    var cityInfoResponse;

    if (userInfo.deactivated == '0') {
      if (userInfo.canAccess == true) {
        cityInfoResponse = City.fromJson(userInfo.city);
        _firstName = userInfo.firstName;
        _secondName = userInfo.secondName;
        _city = cityInfoResponse.title;
        _photo = userInfo.photo;
        _online = userInfo.online;
        _deactivated = '0';
        _canAccess = true;
      } else {
        cityInfoResponse = City.fromJson(userInfo.city);
        _firstName = userInfo.firstName;
        _secondName = userInfo.secondName;
        _city = cityInfoResponse.title;
        _photo = userInfo.photo;
        _online = userInfo.online;
        _deactivated = '0';
        _canAccess = false;
      }
    } else {
      _firstName = 'Deleted';
      _secondName = 'Deleted';
      _city = 'Deleted';
      _photo = 'assets/images/no-avatar.png';
      _online = 0;
      _deactivated = 'deleted';
    }

    //print(userInfoMap);
    //print(userInfo.deactivated);
    notifyListeners();
  }

  Future getUserPhotos(token, id) async {
    if (_deactivated == '0' && _canAccess == true) {
      var getUserPhotos = await http.get(Uri.parse(
          'https://api.vk.com/method/photos.getAll?v=5.131&access_token=${token}&owner_id=$id&count=6'));

      var userPhotosMap = jsonDecode(getUserPhotos.body);
      var userPhotosResponse = PhotosResponse.fromJson(userPhotosMap);
      var userPhotoResponseItems =
          PhotosItems.fromJson(userPhotosResponse.response);

      var userPhotoResponseItemsSizes = userPhotoResponseItems.items
          .map((e) => PhotosItemsResponse.fromJson(e))
          .toList();

      var listSizes = userPhotoResponseItemsSizes.map((e) {
        return PhotosItemsSizesItems.fromJson(e.sizes.last);
      }).toList();

      _urls =
          listSizes.map((e) => PhotosItemsUrl.fromJson(e.size).url).toList();

      //print(id);

      notifyListeners();
    } else {
      _urls = [
        'assets/images/no-avatar.png',
        'assets/images/no-avatar.png',
        'assets/images/no-avatar.png',
        'assets/images/no-avatar.png',
        'assets/images/no-avatar.png',
        'assets/images/no-avatar.png'
      ];
      notifyListeners();
    }
  }
}

class ResponseInfo {
  final List response;

  ResponseInfo({required this.response, deactivated});

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      response: json['response'],
    );
  }
}

class UserInfo {
  final String deactivated;
  final bool canAccess;
  final String firstName;
  final String secondName;
  final String photo;
  Map<String, dynamic> city = {};
  int online = 0;

  UserInfo({
    required this.deactivated,
    required this.canAccess,
    required this.firstName,
    required this.secondName,
    required this.photo,
    required this.city,
    required this.online,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      deactivated: json['deactivated'] ?? '0',
      canAccess: json['can_access_closed'] ?? true,
      firstName: json['first_name'],
      secondName: json['last_name'],
      photo: json['photo_100'],
      city: json['city'] ?? {},
      online: json['online'] != null ? 1 : 0,
    );
  }
}

class CityResponse {
  final City cityresponse;

  CityResponse({required this.cityresponse});

  factory CityResponse.fromJson(Map<int, dynamic> json) {
    return CityResponse(
      cityresponse: json[0],
    );
  }
}

class City {
  String title = '';

  City({required this.title});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      title: json['title'] ?? '',
    );
  }
}

/* /////////////////////////////////////////////////////// */

class PhotosResponse {
  final Map<String, dynamic> response;

  PhotosResponse({required this.response});

  factory PhotosResponse.fromJson(Map<String, dynamic> json) {
    return PhotosResponse(
      response: json['response'] as Map<String, dynamic>,
    );
  }
}

class PhotosItems {
  final List items;

  PhotosItems({required this.items});

  factory PhotosItems.fromJson(Map<String, dynamic> json) {
    return PhotosItems(
      items: json['items'],
    );
  }
}

class PhotosItemsResponse {
  final String id;
  final List sizes;

  PhotosItemsResponse({required this.id, required this.sizes});

  factory PhotosItemsResponse.fromJson(Map<String, dynamic> json) {
    return PhotosItemsResponse(
      id: json['id'].toString(),
      sizes: json['sizes'],
    );
  }
}

class PhotosItemsSizesItems {
  final Map<String, dynamic> size;

  PhotosItemsSizesItems({required this.size});

  factory PhotosItemsSizesItems.fromJson(json) {
    return PhotosItemsSizesItems(
      size: json,
    );
  }
}

class PhotosItemsUrl {
  final String url;

  PhotosItemsUrl({required this.url});

  factory PhotosItemsUrl.fromJson(Map<String, dynamic> json) {
    return PhotosItemsUrl(
      url: json['url'],
    );
  }
}
