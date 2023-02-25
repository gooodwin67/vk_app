import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/get_user_info_entity.dart';
import 'package:vk_app/entities/models/get_my_friends_list_model.dart';
import 'package:vk_app/entities/models/get_my_info_model.dart';
import 'package:vk_app/entities/models/get_my_photos_model.dart';
import 'package:vk_app/entities/models/get_my_wall_model.dart';

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double height = 400;
    double widthImage = 100;

    UserInfo userInfo = context.watch<GetMyInfoModel>().userInfo;
    Counters counters = Counters.fromJson(userInfo.counters);

    String city = context.watch<GetMyInfoModel>().city;

    Image photo = Image.asset('assets/images/no-avatar.png');

    if (context.read<GetMyInfoModel>().userInfo.deactivated == '0') {
      photo = Image.network(context.read<GetMyInfoModel>().userInfo.photo);
    } else {
      Image.asset('ssets/images/no-avatar.png');
    }

    String deactivated = context.read<GetMyInfoModel>().userInfo.deactivated;
    bool canAccess = context.read<GetMyInfoModel>().userInfo.canAccess;
    int id = context.read<GetMyInfoModel>().userInfo.id;

    List listPhotos = context.watch<MyPhotosModel>().photos;

    List friendsList =
        context.read<MyFriendsScreenModel>().userFriendsListInfoAll;
    int allFriendsCount = context.read<MyFriendsScreenModel>().count;

    bool isCover = context.watch<GetMyInfoModel>().isCover;
    String coverUrl = context.watch<GetMyInfoModel>().coverUrl;

    List itemsInWall = context.watch<GetMyWallModel>().itemsInWall;
    //print(itemsInWall[0].listAttachmentType);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   toolbarHeight: 40,
        //   leadingWidth: 40,
        //   leading: Container(
        //     margin: EdgeInsets.only(left: 10, top: 10),
        //     child: InkWell(
        //       customBorder: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(50),
        //       ),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       // child: Container(
        //       //   decoration: BoxDecoration(
        //       //     borderRadius: BorderRadius.circular(50),
        //       //     color: constants.secondColor.withAlpha(170),
        //       //   ),
        //       //   child: Icon(
        //       //     Icons.arrow_back,
        //       //     color: Colors.white.withAlpha(230),
        //       //     size: 17,
        //       //   ),
        //       // ),
        //     ),
        //   ),
        // ),
        body: CustomScrollView(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
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
                                    : const SizedBox(),
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
                                    Material(
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(10)),
                                            ),
                                            context: context,
                                            builder: (context) => Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Icon(Icons.close,
                                                            color: constants
                                                                .mainColor),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      const Text(
                                                        'Подробнее',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .alternate_email_outlined,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Text(userInfo.domain),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .card_giftcard_outlined,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Text(
                                                        'День рождения: ${userInfo.bdate}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 99, 99, 99),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Text(
                                                        userInfo.relationString
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 99, 99, 99),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  city == null
                                                      ? SizedBox()
                                                      : Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 5),
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .home_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                const SizedBox(
                                                                    width: 15),
                                                                Text(
                                                                  'Город: $city',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            99,
                                                                            99,
                                                                            99),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.wifi,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Text(
                                                        'Подписчиков: ${userInfo.followersCount}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 99, 99, 99),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Divider(),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .supervisor_account_outlined,
                                                        color:
                                                            constants.mainColor,
                                                      ),
                                                      const SizedBox(width: 15),
                                                      const Text(
                                                        'Друзья',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 32, 32, 32),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${counters.friends}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 99, 99, 99),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  counters.mutualFriends == null
                                                      ? const SizedBox()
                                                      : Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .groups_outlined,
                                                                  color: constants
                                                                      .mainColor,
                                                                ),
                                                                const SizedBox(
                                                                    width: 15),
                                                                const Text(
                                                                  'Общие друзья',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            32,
                                                                            32,
                                                                            32),
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                  '${counters.mutualFriends}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            99,
                                                                            99,
                                                                            99),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                          ],
                                                        ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.groups_outlined,
                                                        color:
                                                            constants.mainColor,
                                                      ),
                                                      const SizedBox(width: 15),
                                                      const Text(
                                                        'Сообщества',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 32, 32, 32),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${counters.groups}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 99, 99, 99),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "${userInfo.firstName} ${userInfo.secondName}",
                                              style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                city != null
                                                    ? Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            size: 20,
                                                            color: constants
                                                                .secondColor
                                                                .withAlpha(150),
                                                          ),
                                                          const SizedBox(
                                                              width: 3),
                                                          Text(
                                                            city.toString(),
                                                            style: TextStyle(
                                                                color: constants
                                                                    .secondColor
                                                                    .withAlpha(
                                                                        180)),
                                                          ),
                                                        ],
                                                      )
                                                    : const Text(''),
                                                const SizedBox(width: 10),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.info_outline,
                                                      size: 20,
                                                      color: constants
                                                          .secondColor
                                                          .withAlpha(150),
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      'Подробнее',
                                                      style: TextStyle(
                                                          color: constants
                                                              .secondColor
                                                              .withAlpha(180)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                              const SizedBox(width: 10),
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
                                              const SizedBox(width: 10),
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
                                        : const SizedBox(height: 0),
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
                                  const Positioned(
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
                      const SizedBox(height: 10),
                      deactivated == '0' && canAccess == true
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    context.go('/profile/my-friends');
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
                                          style: const TextStyle(
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
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      deactivated == '0' && canAccess == false
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Профиль закрыт'),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
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
                                          padding: const EdgeInsets.symmetric(
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
                                              const SizedBox(width: 5),
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
                                  const SizedBox(height: 15),
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
                                            const SizedBox(width: 5),
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
                                                  .read<MyPhotosModel>()
                                                  .clearPhotosList()
                                                  .then((value) => context
                                                      .read<MyPhotosModel>()
                                                      .getMyPhotos(
                                                          context, 200, 0)
                                                      .then(
                                                        (value) => context.go(
                                                            '/profile/photos'),
                                                      ));
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
                                                const SizedBox(width: 5),
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
                                  const SizedBox(height: 15),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
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
                                    const SizedBox(width: 5),
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
                          : const SizedBox(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  context.watch<GetMyWallModel>().showIndex(context, index);
                  var listPhotoItem = itemsInWall[index]
                      .listAttachmentType
                      .where((e) => e == 'photo' || e == 'doc' || e == 'gif');
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: itemsInWall.isEmpty
                            ? const SizedBox()
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
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${itemsInWall[index].firstName} ${itemsInWall[index].lastName}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 70, 70, 70)),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              itemsInWall[index].date,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.more_horiz_outlined,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemsInWall[index].groupName == 'groupName'
                                      ? const SizedBox()
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
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
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
                                                              style: const TextStyle(
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
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        itemsInWall[index].date,
                                                        style: const TextStyle(
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
                                              const SizedBox(height: 7),
                                              itemsInWall[index]
                                                          .postGroupText ==
                                                      ''
                                                  ? const SizedBox()
                                                  : Text(
                                                      itemsInWall[index]
                                                          .postGroupText,
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                            ],
                                          ),
                                        ),
                                  itemsInWall[index].myText == ''
                                      ? const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child:
                                              Text(itemsInWall[index].myText),
                                        ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        listPhotoItem.length == 0
                                            ? const SizedBox()
                                            : GridView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 3 / 1.7,
                                                  crossAxisSpacing: 5,
                                                  mainAxisSpacing: 5,
                                                  crossAxisCount: listPhotoItem
                                                              .length >
                                                          2
                                                      ? 3
                                                      : listPhotoItem.length > 1
                                                          ? 2
                                                          : 1,
                                                ),
                                                itemCount: listPhotoItem.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  return Container(
                                                      child: itemsInWall[index]
                                                                      .listAttachmentType[
                                                                  i] ==
                                                              'photo'
                                                          ? ClipRRect(
                                                              child:
                                                                  FadeInImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    itemsInWall[
                                                                            index]
                                                                        .photosList[i]),
                                                                placeholder:
                                                                    const AssetImage(
                                                                        'assets/images/loading.gif'),
                                                                imageErrorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  print(
                                                                      error); //do something
                                                                  return Image
                                                                      .asset(
                                                                          'assets/images/no-avatar.png');
                                                                },
                                                              ),
                                                            )
                                                          : null);
                                                },
                                              ),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: itemsInWall[index]
                                              .listAttachmentType
                                              .length,
                                          itemBuilder: ((context, i) {
                                            return Container(
                                              child: itemsInWall[index]
                                                              .listAttachmentType[
                                                          i] ==
                                                      'doc'
                                                  ? FadeInImage(
                                                      fit: BoxFit.contain,
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
                                                  : const SizedBox(),
                                            );
                                          }),
                                        ),
                                        SizedBox(height: 10),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: itemsInWall[index]
                                              .listAttachmentType
                                              .length,
                                          itemBuilder: ((context, i) {
                                            return itemsInWall[index]
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
                                                              EdgeInsets.all(2),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
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
                                                              itemsInWall[index]
                                                                  .link
                                                                  .linkTitle,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              itemsInWall[index]
                                                                  .link
                                                                  .linkUrl,
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
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
                                                : SizedBox();
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        itemsInWall[index].userLikes == 1
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 225, 224),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: const Icon(
                                                        Icons.favorite,
                                                        size: 13,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(itemsInWall[index]
                                                        .likes
                                                        .toString()),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: constants.backColor,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.favorite_border,
                                                      size: 23,
                                                      color: Color.fromARGB(
                                                          255, 110, 110, 110),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(itemsInWall[index]
                                                        .likes
                                                        .toString()),
                                                  ],
                                                ),
                                              ),
                                        const SizedBox(width: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
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
                                                child: const Icon(
                                                  Icons.reply_outlined,
                                                  size: 23,
                                                  color: Color.fromARGB(
                                                      255, 110, 110, 110),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(itemsInWall[index]
                                                  .reposts
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        itemsInWall[index].views == 0
                                            ? const SizedBox()
                                            : Row(
                                                children: [
                                                  const Icon(
                                                    Icons.remove_red_eye,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        255, 158, 158, 158),
                                                  ),
                                                  const SizedBox(width: 10),
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
                      const SizedBox(height: 5),
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
