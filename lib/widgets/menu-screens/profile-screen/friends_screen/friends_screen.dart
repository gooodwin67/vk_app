import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/models/get_my_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/routes/routes.dart';

class FriendsScreenWidget extends StatelessWidget {
  const FriendsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final navId = arg['id'];
    List friendsList =
        context.watch<MyFriendsScreenModel>().userFriendsListInfo;
    int count = context.watch<MyFriendsScreenModel>().count;

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
                                .go('/main/friends/${friendsList[index].id}'));
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
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    friendsList[index].photo.toString()),
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
                childCount: count,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
