import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/get_user_wall_entity.dart';
import 'package:intl/date_symbol_data_local.dart';

class GetMyWallModel extends ChangeNotifier {
  int allWallCount = 0;
  int _count = 0;
  List itemsInWall = [];

  int currentPage = 1;
  int get count => _count;

  Future getMyWall(BuildContext context, count, offset) async {
    final token = context.read<ApiClient>().token;

    var getMyWall = await http.get(Uri.parse(
        'https://api.vk.com/method/wall.get?v=5.131&access_token=$token&extended=1&offset=$offset&count=$count'));

    var userWallMap = jsonDecode(getMyWall.body);

    var userWallResponse = ResponseWall.fromJson(userWallMap);

    var userWallResponseItemsResponse =
        UserWall.fromJson(userWallResponse.response).items;
    var userWallResponseProfilesResponse =
        UserWall.fromJson(userWallResponse.response).profiles;
    var userWallResponseGroupsResponse =
        UserWall.fromJson(userWallResponse.response).groups;

    _count = UserWall.fromJson(userWallResponse.response).count;

    List itemsWall = userWallResponseItemsResponse
        .map((e) => UserWallItems.fromJson(e))
        .toList();

    List profilesWall = userWallResponseProfilesResponse
        .map((e) => UserWallProfiles.fromJson(e))
        .toList();

    List groupsWall = userWallResponseGroupsResponse
        .map((e) => UserWallGroups.fromJson(e))
        .toList();

    itemsInWall.addAll(itemsWall.map((e) {
      var likes = Likes.fromJson(e.likes);
      var reposts = Reposts.fromJson(e.reposts);
      var views = Views.fromJson(e.views);
      var firstName = 'firstName';
      var lastName = 'lastName';
      var photoProfile = 'photoProfile';
      var date = DateTime.fromMillisecondsSinceEpoch(e.date * 1000);
      var myText = e.text;
      var repostFromId = CopyHistory.fromJson(e.copyHistory[0]);
      var groupName = 'groupName';
      var photoGroup = 'photoGroup';
      var postGroupText = CopyHistory.fromJson(e.copyHistory[0]);
      var attachmentType = 'defaultType';
      var docExt = 'gif'; // тип документа doc (пока что только gif)
      List listAttachmentType = [];

      List attachmentsResponse;
      if (e.attachments.isNotEmpty) {
        attachmentsResponse = e.attachments;
      } else if (repostFromId.fromId != 0) {
        attachmentsResponse = repostFromId.attachments;
      } else {
        attachmentsResponse = [];
      }

      //attachmentType = Attachments.fromJson(attachmentsResponse[0]).type;

      var linkUrl = '';
      var linkTitle = '';
      var linkPhotoUrl = '';

      var photoUrl = '';
      List<String> photosList = [];

      List attachments = attachmentsResponse.map((e) {
        attachmentType = Attachments.fromJson(e).type;
        listAttachmentType.add(attachmentType);

        var attachment;

        if (attachmentType == 'photo') {
          attachment = TypePhotoResponse.fromJson(e);

          var photoPhotoResponse = attachment.photo;
          var photoPhotos = LinkPhotos.fromJson(photoPhotoResponse);

          photoUrl = LinkPhotoUrl.fromJson(photoPhotos.sizes.last).url;
          photosList.add(photoUrl);
        } else if (attachmentType == 'link') {
          attachment = TypeLinkResponse.fromJson(e);
          var linkResponse = Link.fromJson(attachment.link);
          linkUrl = linkResponse.url;
          linkTitle = linkResponse.title;

          var linkPhotoResponse = linkResponse.photo;
          var linkPhotos = LinkPhotos.fromJson(linkPhotoResponse);

          linkPhotoUrl = linkPhotos.sizes.isEmpty
              ? ''
              : LinkPhotoUrl.fromJson(linkPhotos.sizes[0]).url;
        } else if (attachmentType == 'doc') {
          attachment = TypeDocResponse.fromJson(e);

          var photoPhotoResponse = TypeDocPreview.fromJson(attachment.doc);
          docExt = photoPhotoResponse.ext;
          if (docExt == 'gif') {
            var docPhotosResponse =
                TypePhotoResponse.fromJson(photoPhotoResponse.preview);

            var docPhotos = PhotoPhotos.fromJson(docPhotosResponse.photo);

            photoUrl = LinkDocUrl.fromJson(docPhotos.sizes[0]).src;
          }

          var docPhotosResponse =
              TypePhotoResponse.fromJson(photoPhotoResponse.preview);

          var docPhotos = PhotoPhotos.fromJson(docPhotosResponse.photo);

          photoUrl = LinkDocUrl.fromJson(docPhotos.sizes[0]).src;
        }
        return attachment;
      }).toList();

      //print(attachments);

      initializeDateFormatting('ru_RU', null);

      var formatDate = DateFormat.yMd().format(date);

      profilesWall.forEach((element) {
        if (element.id == e.fromId) {
          firstName = element.firstName;
          lastName = element.lastName;
          photoProfile = element.photoProfile;
        }
      });

      groupsWall.forEach((element) {
        if (element.idGroup == repostFromId.fromId.abs()) {
          groupName = element.nameGroup;
          photoGroup = element.photoGroup;
        }
      });

      return ItemInWall(
        date: formatDate.replaceAll('/', '.'),
        myText: myText,
        fromId: e.fromId,
        likes: likes.count,
        reposts: reposts.count,
        views: views.count,
        userLikes: likes.userLikes,
        firstName: firstName,
        lastName: lastName,
        photoProfile: photoProfile,
        groupName: groupName,
        photoGroup: photoGroup,
        postGroupText: postGroupText.postGroupText,
        attachmentType: attachmentType,
        listAttachmentType: listAttachmentType,
        photosList: photosList,
        link: LinkRes(
          linkUrl: linkUrl,
          linkTitle: linkTitle,
          linkPhotoUrl: linkPhotoUrl,
        ),
        photo: PhotoRes(
          photoUrl: photoUrl,
        ),
        docExt: docExt,
      );
    }).toList());

    //print(ItemInWall.link);

    notifyListeners();
  }

  void showIndex(context, index) {
    //print('$index ------ ${itemsInWall.length} ----- count $_count');
    if (index < itemsInWall.length - 1) return;

    var offset;

    if (index < _count - 2) {
      offset = 5 * currentPage;
      getMyWall(context, 5, offset);
      currentPage++;
    } else {
      return;
    }
  }
}

class ItemInWall {
  int fromId;
  String lastName = 'lastName';
  String firstName = 'firstName';
  String date;
  String myText;
  int likes;
  int userLikes;
  int reposts;
  int views;
  String photoProfile;
  String groupName;
  String photoGroup;
  String postGroupText;
  String attachmentType;
  List listAttachmentType;
  List photosList;
  LinkRes link;
  PhotoRes photo;
  String docExt;

  ItemInWall({
    required this.fromId,
    required this.firstName,
    required this.lastName,
    required this.date,
    required this.myText,
    required this.likes,
    required this.userLikes,
    required this.reposts,
    required this.views,
    required this.photoProfile,
    required this.groupName,
    required this.photoGroup,
    required this.postGroupText,
    required this.attachmentType,
    required this.photosList,
    required this.listAttachmentType,
    required this.link,
    required this.photo,
    required this.docExt,
  });
}

class LinkRes {
  final String linkUrl;
  final String linkTitle;
  final String linkPhotoUrl;

  LinkRes(
      {required this.linkUrl,
      required this.linkTitle,
      required this.linkPhotoUrl});
}

class PhotoRes {
  final String photoUrl;

  PhotoRes({
    required this.photoUrl,
  });
}
