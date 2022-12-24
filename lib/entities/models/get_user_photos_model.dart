import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_photos_entity.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';

class UserPhotosModel extends ChangeNotifier {
  bool _canAccess = true;

  List _photos = [];
  String _id = '0';
  int _count = 0;
  int _galeryIndex = 0;
  int currentPage = 1;

  bool get canAccess => _canAccess;
  List get photos => _photos;
  String get id => _id;
  int get count => _count;
  int get galeryIndex => _galeryIndex;

  Future getUserPhotos(BuildContext context, id, count, offset) async {
    String deactivated = context.read<GetUserInfoModel>().userInfo.deactivated;
    bool canAccess = context.read<GetUserInfoModel>().userInfo.canAccess;
    final token = context.read<ApiClient>().token;
    //print('id $id count $count');

    if (deactivated == '0' && canAccess == true) {
      var getUserPhotos = await http.get(Uri.parse(
          'https://api.vk.com/method/photos.getAll?v=5.131&access_token=${token}&owner_id=$id&count=$count&offset=${offset}&extended=1'));

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

      _count = userPhotoResponseItems.count;
      _id = id.toString();

      notifyListeners();
    } else {
      _photos = [
        Photo(
            url: 'assets/images/no-avatar.png',
            text: '',
            likes: 0,
            userLikes: 0,
            reposts: 0),
        Photo(
            url: 'assets/images/no-avatar.png',
            text: '',
            likes: 0,
            userLikes: 0,
            reposts: 0),
        Photo(
            url: 'assets/images/no-avatar.png',
            text: '',
            likes: 0,
            userLikes: 0,
            reposts: 0),
        Photo(
            url: 'assets/images/no-avatar.png',
            text: '',
            likes: 0,
            userLikes: 0,
            reposts: 0),
        Photo(
            url: 'assets/images/no-avatar.png',
            text: '',
            likes: 0,
            userLikes: 0,
            reposts: 0),
        Photo(
            url: 'assets/images/no-avatar.png',
            text: '',
            likes: 0,
            userLikes: 0,
            reposts: 0),
      ];
      notifyListeners();
    }
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
      getUserPhotos(context, _id, 200, offset);
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
