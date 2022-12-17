import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/models/get_my_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/entities/models/get_user_photos_model.dart';
import 'package:vk_app/routes/routes.dart';

class ProfileFriendsScreenWidget extends StatelessWidget {
  const ProfileFriendsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final navId = arg['id'];
    List friendsList = context.watch<FriendsScreenModel>().userFriendsListInfo;
    int count = context.watch<FriendsScreenModel>().count;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              floating: true,
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Все друзья',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      count.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: constants.secondColor),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.keyboard_arrow_down_outlined,
                        color: constants.mainColor),
                    Spacer(),
                    Icon(Icons.add, color: constants.mainColor, size: 25),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    SizedBox(height: constants.mainPadding),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        //color: constants.secondColor.withAlpha(100),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: const TextField(
                          decoration: InputDecoration(
                            labelText: 'Поиск',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: constants.mainPadding),
                  ],
                ),
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(bottom: constants.mainPadding),
                    child: InkWell(
                      onTap: () {
                        context
                            .read<GetUserInfoModel>()
                            .getUserInfo(context, friendsList[index].id)
                            .then((value) => context
                                .read<UserPhotosModel>()
                                .getUserPhotos(
                                    context, friendsList[index].id, 6))
                            .then((value) => context.go(
                                '/main/my-friends/${friendsList[index].id}'))
                            .then((value) => context
                                .read<FriendsScreenModel>()
                                .getUserFriends(context, friendsList[index].id,
                                    300)); //ПОПРАВИТЬ!
                      },
                      child: friendsList.length < 1
                          ? LinearProgressIndicator(
                              backgroundColor: constants.backColor,
                              color: constants.secondColor.withAlpha(30),
                              minHeight: 50,
                            )
                          : Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: FadeInImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(friendsList[index]
                                              .photo
                                              .toString()),
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
                                      child: friendsList[index].online == 1
                                          ? friendsList[index].online_mobile ==
                                                  1
                                              ? MobileOnlineIcon()
                                              : DesctopOnlineIcon()
                                          : SizedBox(),
                                    )
                                  ],
                                ),
                                SizedBox(width: 10),
                                friendsList.length > 0
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: Text(
                                          '${friendsList[index].firstName} ${friendsList[index].lastName}',
                                          style: TextStyle(fontSize: 17),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : Text(
                                        'Нет доступа',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                Spacer(),
                                Icon(
                                  Icons.message_outlined,
                                  color: constants.mainColor,
                                )
                              ],
                            ),
                    ),
                  );
                },
                childCount: count,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
