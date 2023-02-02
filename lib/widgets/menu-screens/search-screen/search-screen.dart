import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/entities/models/get_user_photos_model.dart';
import 'package:vk_app/entities/models/get_user_wall_model.dart';
import 'package:vk_app/entities/models/user_search_model.dart';

class SearchScreenWidget extends StatelessWidget {
  const SearchScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List usersList = context.watch<SearchScreenModel>().userList;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: constants.mainPadding,
            right: constants.mainPadding,
            top: constants.mainPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                floating: false,
                title: TextField(
                  onSubmitted: (value) {
                    context.read<SearchScreenModel>().clearUsersList();
                    context
                        .read<SearchScreenModel>()
                        .getUsersSearch(context, value);
                  },
                  decoration: InputDecoration(
                    label: Text('Поиск'),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: constants.backColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Все',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: constants.secondColor
                                            .withAlpha(150)),
                                  ),
                                  SizedBox(width: 20),
                                  const Text(
                                    'Люди',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Сообщества',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: constants.secondColor
                                            .withAlpha(150)),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Новости',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: constants.secondColor
                                            .withAlpha(150)),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: constants.secondColor,
                              ),
                            ],
                          ),
                        ),
                    childCount: 1),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == usersList.length - 3) {
                      context
                          .read<SearchScreenModel>()
                          .getUsersSearch(context, '');
                    }
                    return InkWell(
                      onTap: () {
                        context
                            .read<UserPhotosModel>()
                            .clearPhotosList()
                            .then((value) => context
                                .read<GetUserWallModel>()
                                .clearUserWallList())
                            .then((value) => context
                                .read<GetUserInfoModel>()
                                .getUserInfo(context, usersList[index].id)
                                .then((value) => context
                                    .read<UserPhotosModel>()
                                    .getUserPhotos(
                                        context, usersList[index].id, 6, 0))
                                .then((value) {
                                  if (context
                                      .read<GetUserInfoModel>()
                                      .userInfo
                                      .canAccess) {
                                    context
                                        .read<GetUserWallModel>()
                                        .getUserWall(
                                            context, 5, 0, usersList[index].id);
                                  }
                                })
                                .then((value) => context
                                    .go('/search/${usersList[index].id}'))
                                .then((value) => context
                                    .read<FriendsScreenModel>()
                                    .getUserFriends(
                                        context, usersList[index].id)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: constants.mainPadding),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          usersList[index].photo.toString()),
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
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: usersList[index].online == 1
                                      ? usersList[index].online_mobile == 1
                                          ? MobileOnlineIcon()
                                          : DesctopOnlineIcon()
                                      : SizedBox(),
                                )
                              ],
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Text(
                                '${usersList[index].firstName} ${usersList[index].lastName}',
                                style: TextStyle(fontSize: 17),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.person_add_alt_1_outlined,
                              color: constants.mainColor,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: usersList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
