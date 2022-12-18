import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_photos_entity.dart';

class MyPhotosModel extends ChangeNotifier {
  List _urls = [];
  int _count = 0;

  List get urls => _urls;
  int get count => _count;

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
}
