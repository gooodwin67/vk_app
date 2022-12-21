import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';

import 'package:vk_app/entities/get_user_info_entity.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/entities/models/get_user_photos_model.dart';

class FriendProfileScreenWidget extends StatelessWidget {
  var userId;
  FriendProfileScreenWidget({required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(userId);
    // final arg = ModalRoute.of(context)!.settings.arguments as Map;
    // final navId = arg['id'];
    var width = MediaQuery.of(context).size.width;
    double height = 400;
    double widthImage = 100;

    UserInfo userInfo = context.watch<GetUserInfoModel>().userInfo;
    String city = context.watch<GetUserInfoModel>().city;

    Image photo = Image.asset('assets/images/no-avatar.png');

    if (context.read<GetUserInfoModel>().userInfo.deactivated == '0') {
      photo = Image.network(context.read<GetUserInfoModel>().userInfo.photo);
    } else {
      Image.asset('ssets/images/no-avatar.png');
    }

    String deactivated = context.read<GetUserInfoModel>().userInfo.deactivated;
    bool canAccess = context.read<GetUserInfoModel>().userInfo.canAccess;

    int online = context.watch<GetUserInfoModel>().userInfo.online;
    int online_mobile =
        context.watch<GetUserInfoModel>().userInfo.online_mobile;
    //print(online_mobile);

    List listUrlsPhotos = context.watch<UserPhotosModel>().urls;

    List friendsList =
        context.watch<FriendsScreenModel>().userFriendsListInfoAll;
    int allFriendsCount = context.read<FriendsScreenModel>().count;

    bool isCover = context.watch<GetUserInfoModel>().isCover;
    String coverUrl = context.watch<GetUserInfoModel>().coverUrl;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 40,
          leadingWidth: 40,
          leading: Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: constants.secondColor.withAlpha(170),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white.withAlpha(230),
                  size: 17,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Container(
            color: constants.backColor,
            child: Column(
              children: [
                Container(
                  height: height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          color: Colors.grey,
                          height: height / 2 + 12, //cover borderRadius
                          width: width,
                          child: isCover
                              ? Image.network(
                                  coverUrl,
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: width,
                          height: height / 2,
                          padding: EdgeInsets.only(
                              top: widthImage / 2 + 12,
                              bottom: 15,
                              left: 15,
                              right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${userInfo.firstName} ${userInfo.secondName}",
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  city != ''
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 20,
                                              color: constants.secondColor
                                                  .withAlpha(150),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              city.toString(),
                                              style: TextStyle(
                                                  color: constants.secondColor
                                                      .withAlpha(180)),
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                                  SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 20,
                                        color: constants.secondColor
                                            .withAlpha(150),
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        'Подробнее',
                                        style: TextStyle(
                                            color: constants.secondColor
                                                .withAlpha(180)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              deactivated == '0'
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    constants.mainColor,
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.message_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Сообщение',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  constants.backColor,
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 10),
                                            child: Icon(
                                              Icons.group_remove_outlined,
                                              color: constants.mainColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  constants.backColor,
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 10),
                                            child: Icon(
                                              Icons.more_horiz_outlined,
                                              color: constants.mainColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(height: 0),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 2 - widthImage / 2,
                        left: width / 2 - widthImage / 2,
                        child: Stack(
                          children: [
                            Container(
                              width: widthImage,
                              height: widthImage,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white, width: 3)),
                              child: ClipRRect(
                                child: photo,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            online == 1
                                ? online_mobile == 1
                                    ? Positioned(
                                        right: 9,
                                        bottom: 9,
                                        child: MobileOnlineIcon())
                                    : Positioned(
                                        right: 9,
                                        bottom: 9,
                                        child: DesctopOnlineIcon())
                                : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                deactivated == '0' && canAccess == true
                    ? friendsList.length < 1
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              color: constants.secondColor.withAlpha(30),
                              minHeight: 50,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              context.go('/main/my-friends/${userId}/friends');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: constants.mainPadding,
                                  vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Друзей: $allFriendsCount'.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  friendsList.length > 2
                                      ? Container(
                                          width: 80,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 50,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                      width: 2,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: FadeInImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          friendsList[2]
                                                              .photo
                                                              .toString()),
                                                      placeholder: const AssetImage(
                                                          'assets/images/loading.gif'),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        print(
                                                            error); //do something
                                                        return Image.asset(
                                                            'assets/images/no-avatar.png');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 25,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                      width: 2,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: FadeInImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          friendsList[1]
                                                              .photo
                                                              .toString()),
                                                      placeholder: const AssetImage(
                                                          'assets/images/loading.gif'),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        print(
                                                            error); //do something
                                                        return Image.asset(
                                                            'assets/images/no-avatar.png');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: FadeInImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        friendsList[0]
                                                            .photo
                                                            .toString()),
                                                    placeholder: const AssetImage(
                                                        'assets/images/loading.gif'),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      print(
                                                          error); //do something
                                                      return Image.asset(
                                                          'assets/images/no-avatar.png');
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          )
                    : SizedBox(),
                deactivated == '0' && canAccess == false
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('Профиль закрыт'),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 10),
                deactivated == '0' && canAccess == true
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: constants.mainPadding, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                            color: constants.backColor)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.photo_outlined,
                                          color: constants.mainColor,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Фото',
                                          style: TextStyle(
                                              color: constants.mainColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: MediaQuery.removePadding(
                                removeTop: true,
                                context: context,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      maxCrossAxisExtent:
                                          MediaQuery.of(context).size.width / 3,
                                      childAspectRatio: 1,
                                    ),
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      return listUrlsPhotos.length < 1
                                          ? SizedBox()
                                          : Container(
                                              color: constants.backColor,
                                              child: FadeInImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    listUrlsPhotos[index]
                                                        .toString()),
                                                placeholder: const AssetImage(
                                                    'assets/images/loading.gif'),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  print(error); //do something
                                                  return Image.asset(
                                                      'assets/images/no-avatar.png');
                                                },
                                              ),
                                            );
                                    }),
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.add,
                                          color: constants.mainColor),
                                      SizedBox(width: 5),
                                      Text(
                                        'Загрузить фото',
                                        style: TextStyle(
                                          color: constants.mainColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<UserPhotosModel>()
                                              .getUserPhotos(
                                                  context, userId, 200)
                                              .then((value) => context.go(
                                                  '/main/my-friends/${userId}/photos'));
                                        },
                                        child: Text(
                                          'Показать все',
                                          style: TextStyle(
                                            color: constants.mainColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.chevron_right_outlined,
                                          color: constants.mainColor),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 10),
                deactivated == '0' && canAccess == true
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: constants.mainPadding, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: constants.mainPadding, vertical: 5),
                          decoration: BoxDecoration(
                            color: constants.backColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_note_outlined,
                                  color: constants.mainColor),
                              SizedBox(width: 5),
                              Text(
                                'Что у вас новго',
                                style: TextStyle(
                                    color: constants.mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
