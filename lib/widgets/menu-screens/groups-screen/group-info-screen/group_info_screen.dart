import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/get_group_info_entity.dart';
import 'package:vk_app/entities/models/get_group_info_model.dart';
import 'package:vk_app/entities/models/get_user_wall_model.dart';

class GroupInfoScreen extends StatefulWidget {
  final String? groupId;
  const GroupInfoScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  var groupInfo;

  @override
  void initState() {
    context.read<GetGroupInfoModel>().getGroupInfo(context, widget.groupId);
    context.read<GetUserWallModel>().clearUserWallList();
    context
        .read<GetUserWallModel>()
        .getUserWall(context, 5, 0, "-${widget.groupId}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var groupInfo = context.watch<GetGroupInfoModel>().groupInfo;
    List itemsInWall = context.watch<GetUserWallModel>().itemsInWall;

    return Scaffold(
      body: groupInfo == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: CustomScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 120,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        groupInfo.cover.toString()),
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
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: FadeInImage(
                                          image: NetworkImage(
                                              groupInfo.photo100.toString()),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        groupInfo.name.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 48, 48, 48)),
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ИНФОРМАЦИЯ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withAlpha(200)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'О компании',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withAlpha(150)),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      groupInfo.description.toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    Divider(color: Colors.black),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              )
                            ],
                          )),
                      childCount: 1,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        context
                            .watch<GetUserWallModel>()
                            .showIndex(context, index);

                        var listPhotoItem = itemsInWall[index]
                            .listAttachmentType
                            .where((e) =>
                                e == 'photo' || e == 'doc' || e == 'gif');

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: FadeInImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        groupInfo.photo100
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
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    child: Text(
                                                      groupInfo.name.toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255, 70, 70, 70)),
                                                    ),
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
                                        itemsInWall[index].groupName ==
                                                'groupName'
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 20,
                                                    right: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  itemsInWall[
                                                                          index]
                                                                      .photoGroup),
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
                                                                  color: Color
                                                                      .fromARGB(
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
                                                                    itemsInWall[
                                                                            index]
                                                                        .groupName,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color.fromARGB(
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
                                                              itemsInWall[index]
                                                                  .date,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color: Color
                                                                    .fromARGB(
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
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                    itemsInWall[index].myText),
                                              ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
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
                                                        childAspectRatio:
                                                            3 / 1.7,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 5,
                                                        crossAxisCount: listPhotoItem
                                                                    .length >
                                                                2
                                                            ? 3
                                                            : listPhotoItem
                                                                        .length >
                                                                    1
                                                                ? 2
                                                                : 1,
                                                      ),
                                                      itemCount:
                                                          listPhotoItem.length,
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
                                                                        itemsInWall[index]
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
                                                              : itemsInWall[index].listAttachmentType[
                                                                              i] ==
                                                                          'doc' &&
                                                                      itemsInWall[index]
                                                                              .docExt[i] ==
                                                                          'gif'
                                                                  ? FadeInImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(itemsInWall[
                                                                              index]
                                                                          .photo
                                                                          .photoUrl),
                                                                      placeholder:
                                                                          const AssetImage(
                                                                              'assets/images/loading.gif'),
                                                                      imageErrorBuilder: (context,
                                                                          error,
                                                                          stackTrace) {
                                                                        print(
                                                                            error); //do something
                                                                        return Image.asset(
                                                                            'assets/images/no-avatar.png');
                                                                      },
                                                                    )
                                                                  : null,
                                                        );
                                                      },
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
                                                                      .circular(
                                                                          5),
                                                              child: Container(
                                                                width: 40,
                                                                height: 40,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
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
                                                                child:
                                                                    FadeInImage(
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                                    return Image
                                                                        .asset(
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
                                                                      height:
                                                                          3),
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
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 255, 225, 224),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Icon(
                                                              Icons.favorite,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                              itemsInWall[index]
                                                                  .likes
                                                                  .toString()),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            constants.backColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .favorite_border,
                                                            size: 23,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    110,
                                                                    110,
                                                                    110),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                              itemsInWall[index]
                                                                  .likes
                                                                  .toString()),
                                                        ],
                                                      ),
                                                    ),
                                              SizedBox(width: 10),
                                              Container(
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
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
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
                                                              255,
                                                              158,
                                                              158,
                                                              158),
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
