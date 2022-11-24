import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProfileScreenModel extends ChangeNotifier {
  String _firstName = 'firstname';
  String _secondName = 'lastname';
  String _city = 'city';
  String _photo = 'assets/images/no-avatar.png';
  int _online = 0;
  List _urls = [];

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

  Future getUserInfo(token) async {
    var getUserInfo = await http.get(Uri.parse(
        'https://api.vk.com/method/users.get?v=5.131&access_token=${token}&fields=city,photo_100,online'));

    var userInfoMap = jsonDecode(getUserInfo.body);
    var userInfoResponse = ResponseInfo.fromJson(userInfoMap);

    var userInfo = UserInfo.fromJson(userInfoResponse.response.first);

    var cityInfoResponse = City.fromJson(userInfo.city);

    _firstName = userInfo.firstName;
    _secondName = userInfo.secondName;
    _city = cityInfoResponse.title;
    _photo = userInfo.photo;
    _online = userInfo.online;

    //print(userInfoMap);
    notifyListeners();
  }

  Future getUserPhotos(token) async {
    var getUserPhotos = await http.get(Uri.parse(
        'https://api.vk.com/method/photos.getAll?v=5.131&access_token=${token}&count=6'));

    var userPhotosMap = jsonDecode(getUserPhotos.body);
    var userPhotosResponse = PhotosResponse.fromJson(userPhotosMap);
    var userPhotoResponseItems =
        PhotosItems.fromJson(userPhotosResponse.response);

    List userPhotoResponseItemsList = userPhotoResponseItems.items
        .map((e) => PhotosItemsSizes.fromJson(e))
        .toList();

    List photosUrls = userPhotoResponseItemsList
        .map((e) => PhotosItemsSizeItem.fromJson(e))
        .toList();

    print(userPhotoResponseItemsList);

    notifyListeners();
  }
}

class ResponseInfo {
  final List response;

  ResponseInfo({required this.response});

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      response: json['response'],
    );
  }
}

class UserInfo {
  final String firstName;
  final String secondName;
  final String photo;
  final Map<String, dynamic> city;
  int online = 0;

  UserInfo({
    required this.firstName,
    required this.secondName,
    required this.photo,
    required this.city,
    required this.online,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['first_name'],
      secondName: json['last_name'],
      photo: json['photo_100'],
      city: json['city'] as Map<String, dynamic>,
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
  final String title;

  City({required this.title});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      title: json['title'],
    );
  }
}

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

class PhotosItemsSizes {
  final List sizes;

  PhotosItemsSizes({required this.sizes});

  factory PhotosItemsSizes.fromJson(Map<String, dynamic> json) {
    return PhotosItemsSizes(
      sizes: json['sizes'],
    );
  }
}

class PhotosItemsSizeItem {
  final Map<int, dynamic> sizeItem;

  PhotosItemsSizeItem({required this.sizeItem});

  factory PhotosItemsSizeItem.fromJson(Map<int, dynamic> json) {
    return PhotosItemsSizeItem(
      sizeItem: json[0],
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


/*
{
"response":{
  "count":46
  "items":[
    0:{
    "album_id":-7
    "date":1574251850
    "id":457241926
    "owner_id":5169164
    "sizes":[
      0:{
      "height":130
      "type":"m"
      "width":130
      "url":"https://sun9-25.userapi.com/impg/c855220/v855220740/17c780/-MnuNYxPK7M.jpg?size=130x130&quality=96&sign=f2086c16b4fa47b750a784cab4edd2ff&c_uniq_tag=uCxE_ozYYiQCpZnhxERg6UYjz4YCLVZY08__S4fBTZo&type=album"
      }
*/