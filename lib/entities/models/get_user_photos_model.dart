import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_photos_entity.dart';

class UserPhotosModel extends ChangeNotifier {
  String _deactivated = '0';
  bool _canAccess = true;

  List _urls = [];
  int _id = 0;

  String get deactivated => _deactivated;
  bool get canAccess => _canAccess;

  List get urls => _urls;
  int get id => _id;

  Future getUserPhotos(BuildContext context, id, count) async {
    _urls = [];
    final token = context.read<ApiClient>().token;
    if (_deactivated == '0' && _canAccess == true) {
      var getUserPhotos = await http.get(Uri.parse(
          'https://api.vk.com/method/photos.getAll?v=5.131&access_token=${token}&owner_id=$id&count=$count'));

      print(getUserPhotos);

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
