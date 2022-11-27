import 'package:flutter/material.dart';
import 'package:vk_app/constants/constants.dart';

class FriendsScreenWidget extends StatelessWidget {
  const FriendsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: constants.mainPadding),
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
                                child: Image.asset(
                                  'assets/images/no-avatar.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Андрей Алейник',
                              style: TextStyle(fontSize: 17),
                            ),
                            Spacer(),
                            Icon(
                              Icons.message_outlined,
                              color: constants.mainColor,
                            )
                          ],
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
