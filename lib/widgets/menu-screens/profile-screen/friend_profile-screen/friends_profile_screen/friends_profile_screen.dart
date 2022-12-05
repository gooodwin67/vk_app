import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friend_profile-screen-model.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friends_profile_screen/friends_profile_screen_model.dart';

class ProfileFriendsScreenWidget extends StatelessWidget {
  const ProfileFriendsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List friendsList =
        context.read<ProfileFriendsScreenModel>().userFriendsListInfo;
    int count = context.read<ProfileFriendsScreenModel>().count;
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
                      '162',
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
                        color: constants.secondColor.withAlpha(100),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
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
                (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: constants.mainPadding),
                        child: InkWell(
                          onTap: () {
                            //print(friendsList[index].id.toString());
                            context
                                .read<FriendProfileScreenModel>()
                                .getUserInfo(context.read<ApiClient>().token,
                                    friendsList[index].id.toString())
                                .then((value) => context
                                    .read<FriendProfileScreenModel>()
                                    .getUserPhotos(
                                        context.read<ApiClient>().token,
                                        friendsList[index].id.toString()))
                                .then((value) => context
                                    .read<ProfileFriendsScreenModel>()
                                    .getUserFriends(
                                        context.read<ApiClient>().token,
                                        friendsList[index].id.toString(),
                                        context
                                            .read<FriendProfileScreenModel>()
                                            .deactivated,
                                        context
                                            .read<FriendProfileScreenModel>()
                                            .canAccess))
                                .then((value) => Navigator.pushNamed(
                                    context, '/main/friends/profile'));
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Image.network(
                                    friendsList[index].photo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${friendsList[index].firstName} ${friendsList[index].lastName}',
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
                  ),
                ),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
