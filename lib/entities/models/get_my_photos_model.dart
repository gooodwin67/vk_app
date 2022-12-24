import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_photos_entity.dart';

class MyPhotosModel extends ChangeNotifier {
  List _photos = [];
  int _count = 0;
  int _galeryIndex = 0;
  int currentPage = 1;

  List get photos => _photos;
  int get count => _count;
  int get galeryIndex => _galeryIndex;

  Future getMyPhotos(BuildContext context, count, offset) async {
    final token = context.read<ApiClient>().token;

    var getUserPhotos = await http.get(Uri.parse(
        'https://api.vk.com/method/photos.getAll?v=5.131&access_token=${token}&count=$count&offset=${offset}&extended=1'));

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
      var likes = PhotosItemsLikes.fromJson(e.likes);
      var reposts = PhotosItemsReposts.fromJson(e.reposts);
      return PhotoRes(
          sizes: size, text: e.text, likes: likes, reposts: reposts);
    }).toList();

    _photos.addAll(listSizes.map((e) {
      return Photo(
        url: PhotosItemsUrl.fromJson(e.sizes.size).url,
        text: e.text,
        likes: e.likes.count,
        userLikes: e.likes.userLikes,
        reposts: e.reposts.count,
      );
    }));

    //print(_photos[1].likes);

    _count = userPhotoResponseItems.count;

    notifyListeners();
  }

  Future clearPhotosList() async {
    _photos.clear();
  }

  void showIndex(context, index) {
    //print('$index ------ ${_urls.length} ----- count $_count');
    if (index < _photos.length - 1) return;

    var offset;

    if (index < _count - 2) {
      offset = 200 * currentPage;
      getMyPhotos(context, 200, offset);
      currentPage++;
    } else {
      return;
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
