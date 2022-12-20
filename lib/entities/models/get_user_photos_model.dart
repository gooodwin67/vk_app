import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_photos_entity.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';

class UserPhotosModel extends ChangeNotifier {
  bool _canAccess = true;

  List _urls = [];
  int _id = 0;
  int _count = 0;
  int _galeryIndex = 0;

  bool get canAccess => _canAccess;

  List get urls => _urls;
  int get id => _id;
  int get count => _count;
  int get galeryIndex => _galeryIndex;

  Future getUserPhotos(BuildContext context, id, count) async {
    _urls = [];
    String deactivated = context.read<GetUserInfoModel>().userInfo.deactivated;
    bool canAccess = context.read<GetUserInfoModel>().userInfo.canAccess;
    final token = context.read<ApiClient>().token;
    print('id $id count $count');

    if (deactivated == '0' && canAccess == true) {
      //print('$id ---- $count');
      var getUserPhotos = await http.get(Uri.parse(
          'https://api.vk.com/method/photos.getAll?v=5.131&access_token=${token}&owner_id=$id&count=$count'));

      var userPhotosMap = jsonDecode(getUserPhotos.body);
      var userPhotosResponse = PhotosResponse.fromJson(userPhotosMap);
      var userPhotoResponseItems =
          PhotosItems.fromJson(userPhotosResponse.response);

      var userPhotoResponseItemsSizes = userPhotoResponseItems.items
          .map((e) => PhotosItemsResponse.fromJson(e))
          .toList();

      var listSizes = userPhotoResponseItemsSizes.map((e) {
        var size;
        e.sizes.length > 3
            ? size = PhotosItemsSizesItems.fromJson(e.sizes[3])
            : size = PhotosItemsSizesItems.fromJson(e.sizes.first);
        return size;
      }).toList();

      _urls =
          listSizes.map((e) => PhotosItemsUrl.fromJson(e.size).url).toList();

      _count = userPhotoResponseItems.count;

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

  photoGalleryInit(index) async {
    _galeryIndex = index;
    notifyListeners();
  }

  photoGalleryDragUpdate2(direction) {
    if (direction == DismissDirection.endToStart) {
      _galeryIndex++;
    } else {
      _galeryIndex--;
    }

    notifyListeners();
  }
}
