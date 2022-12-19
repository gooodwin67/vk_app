import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_photos_entity.dart';

class MyPhotosModel extends ChangeNotifier {
  List _urls = [];
  int _count = 0;
  int _galeryIndex = 0;
  bool _canGaleryDrag = true;

  List get urls => _urls;
  int get count => _count;
  int get galeryIndex => _galeryIndex;
  bool get canGaleryDrag => _canGaleryDrag;

  Future getMyPhotos(BuildContext context, count) async {
    final token = context.read<ApiClient>().token;

    var getUserPhotos = await http.get(Uri.parse(
        'https://api.vk.com/method/photos.getAll?v=5.131&access_token=${token}&count=$count'));

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
          : size = PhotosItemsSizesItems.fromJson(e.sizes.last);
      return size;
    }).toList();

    _urls = listSizes.map((e) => PhotosItemsUrl.fromJson(e.size).url).toList();

    _count = userPhotoResponseItems.count;

    notifyListeners();
  }

  photoGalleryInit(index) async {
    _galeryIndex = index;
    notifyListeners();
  }

  photoGalleryDragUpdate(details) {
    if (details.primaryVelocity == null) return;
    if (details.primaryVelocity! < 0) {
      if (_galeryIndex > 0) {
        _galeryIndex++;
      }
    } else {
      if (_galeryIndex < _count - 1) {
        _galeryIndex--;
      }
    }

    notifyListeners();
  }

  photoGalleryDragUpdate2(direction) {
    if (direction == DismissDirection.endToStart) {
      if (_galeryIndex < _count) {
        _galeryIndex++;
      } else {
        _canGaleryDrag = false;
      }
    } else {
      if (_galeryIndex > 2) {
        _galeryIndex--;
      } else {
        _canGaleryDrag = false;
      }
    }

    notifyListeners();
  }
}
