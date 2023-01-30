import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/get_user_info_entity.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/entities/models/get_user_photos_model.dart';
import 'package:vk_app/entities/models/get_user_wall_model.dart';

class FriendProfileScreenWidget extends StatelessWidget {
  var userId;
  FriendProfileScreenWidget({required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    List listPhotos = context.watch<UserPhotosModel>().photos;

    List friendsList =
        context.watch<FriendsScreenModel>().userFriendsListInfoAll;
    int allFriendsCount = context.read<FriendsScreenModel>().count;

    bool isCover = context.watch<GetUserInfoModel>().isCover;
    String coverUrl = context.watch<GetUserInfoModel>().coverUrl;

    List itemsInWall = context.watch<GetUserWallModel>().itemsInWall;

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
        body: CustomScrollView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                        color: constants
                                                            .secondColor
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
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  onPressed: () {},
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Icon(
                                                          Icons
                                                              .message_outlined,
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 10),
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 10),
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
                                  Positioned(
                                    right: 7,
                                    bottom: 7,
                                    child: MobileOnlineIcon(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      deactivated == '0' && canAccess == true
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<FriendsScreenModel>()
                                        .clearSerchField();
                                    context.go(
                                        '/profile/my-friends/${userId}/friends');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: constants.mainPadding,
                                        vertical: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Друзей: $allFriendsCount'.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: FadeInImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                friendsList[2]
                                                                    .photo
                                                                    .toString()),
                                                            placeholder:
                                                                const AssetImage(
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
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: FadeInImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                friendsList[1]
                                                                    .photo
                                                                    .toString()),
                                                            placeholder:
                                                                const AssetImage(
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
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: FadeInImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              friendsList[0]
                                                                  .photo
                                                                  .toString()),
                                                          placeholder:
                                                              const AssetImage(
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
                                                  ],
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
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
                                  horizontal: constants.mainPadding),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                            //crossAxisCount: 3,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                            maxCrossAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                            childAspectRatio: 1,
                                          ),
                                          itemCount: listPhotos.length > 5
                                              ? 6
                                              : listPhotos.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              color: constants.backColor,
                                              child: FadeInImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    listPhotos[index]
                                                        .url
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
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
                                        Material(
                                          child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<UserPhotosModel>()
                                                  .clearPhotosList()
                                                  .then((value) => context
                                                      .read<UserPhotosModel>()
                                                      .getUserPhotos(context,
                                                          userId, 200, 0)
                                                      .then((value) => context.go(
                                                          '/profile/my-friends/${userId}/photos')));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Показать все',
                                                  style: TextStyle(
                                                    color: constants.mainColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                    Icons
                                                        .chevron_right_outlined,
                                                    color: constants.mainColor),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 10),
                      deactivated == '0' && canAccess == true
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: constants.mainPadding,
                                  vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: constants.mainPadding,
                                    vertical: 5),
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
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  context.watch<GetUserWallModel>().showIndex(context, index);
                  //print(index);
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: itemsInWall.isEmpty
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: FadeInImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  itemsInWall[index]
                                                      .photoProfile),
                                              placeholder: const AssetImage(
                                                  'assets/images/loading.gif'),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                print(error); //do something
                                                return Image.asset(
                                                    'assets/images/no-avatar.png');
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${itemsInWall[index].firstName} ${itemsInWall[index].lastName}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 70, 70, 70)),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              itemsInWall[index].date,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.more_horiz_outlined,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemsInWall[index].groupName == 'groupName'
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 20, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: FadeInImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            itemsInWall[index]
                                                                .photoGroup),
                                                        placeholder:
                                                            const AssetImage(
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
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .subdirectory_arrow_right_sharp,
                                                            size: 13,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    121,
                                                                    121,
                                                                    121),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.6,
                                                            child: Text(
                                                              itemsInWall[index]
                                                                  .groupName,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          70,
                                                                          70,
                                                                          70)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        itemsInWall[index].date,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255,
                                                              122,
                                                              122,
                                                              122),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 7),
                                              itemsInWall[index]
                                                          .postGroupText ==
                                                      ''
                                                  ? SizedBox()
                                                  : Text(
                                                      itemsInWall[index]
                                                          .postGroupText,
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                            ],
                                          ),
                                        ),
                                  itemsInWall[index].myText == ''
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child:
                                              Text(itemsInWall[index].myText),
                                        ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: itemsInWall[index]
                                            .listAttachmentType
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              itemsInWall[index]
                                                              .listAttachmentType[
                                                          i] ==
                                                      'photo'
                                                  ? FadeInImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          itemsInWall[index]
                                                              .photo
                                                              .photoUrl),
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
                                                    )
                                                  : SizedBox(),
                                              itemsInWall[index].listAttachmentType[
                                                              i] ==
                                                          'doc' &&
                                                      itemsInWall[index]
                                                              .docExt[i] ==
                                                          'gif'
                                                  ? FadeInImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          itemsInWall[index]
                                                              .photo
                                                              .photoUrl),
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
                                                    )
                                                  : SizedBox(),
                                              itemsInWall[index]
                                                              .listAttachmentType[
                                                          i] ==
                                                      'link'
                                                  ? Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        240,
                                                                        240,
                                                                        240),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  itemsInWall[
                                                                          index]
                                                                      .link
                                                                      .linkPhotoUrl),
                                                              placeholder:
                                                                  const AssetImage(
                                                                      'assets/images/loading.gif'),
                                                              imageErrorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                print(
                                                                    error); //do something
                                                                return Image.asset(
                                                                    'assets/images/no-avatar.png');
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 7),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.4,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                itemsInWall[
                                                                        index]
                                                                    .link
                                                                    .linkTitle,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              SizedBox(
                                                                  height: 3),
                                                              Text(
                                                                itemsInWall[
                                                                        index]
                                                                    .link
                                                                    .linkUrl,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        itemsInWall[index].userLikes == 1
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 225, 224),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Icon(
                                                        Icons.favorite,
                                                        size: 13,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(itemsInWall[index]
                                                        .likes
                                                        .toString()),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: constants.backColor,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.favorite_border,
                                                      size: 23,
                                                      color: Color.fromARGB(
                                                          255, 110, 110, 110),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(itemsInWall[index]
                                                        .likes
                                                        .toString()),
                                                  ],
                                                ),
                                              ),
                                        SizedBox(width: 10),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: constants.backColor,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.reply_outlined,
                                                  size: 23,
                                                  color: Color.fromARGB(
                                                      255, 110, 110, 110),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(itemsInWall[index]
                                                  .reposts
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        itemsInWall[index].views == 0
                                            ? SizedBox()
                                            : Row(
                                                children: [
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        255, 158, 158, 158),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(itemsInWall[index]
                                                      .views
                                                      .toString()),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(height: 5),
                    ],
                  );
                },
                childCount: itemsInWall.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
