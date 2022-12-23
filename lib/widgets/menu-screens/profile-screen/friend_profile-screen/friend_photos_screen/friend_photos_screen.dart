import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/models/get_user_photos_model.dart';

class FriendPhotosScreenWidget extends StatelessWidget {
  const FriendPhotosScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List listUrlsPhotos = context.watch<UserPhotosModel>().urls;
    int allCount = context.watch<UserPhotosModel>().count;
    int count = listUrlsPhotos.length;

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
              title: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 206, 206, 206),
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: constants.mainColor,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Фотографии',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(Icons.add, color: constants.mainColor, size: 25),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Все фотографии $allCount',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  context.watch<UserPhotosModel>().showIndex(context, index);
                  return InkWell(
                    onTap: () async {
                      context.read<UserPhotosModel>().photoGalleryInit(index);
                      await showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            insetPadding: EdgeInsets.all(0),
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: Dismissible(
                                          movementDuration:
                                              Duration(microseconds: 300),
                                          resizeDuration: null,
                                          confirmDismiss: (direction) async {
                                            var canDrag;
                                            ;
                                            if (direction ==
                                                DismissDirection.endToStart) {
                                              canDrag = true;
                                              context
                                                          .read<
                                                              UserPhotosModel>()
                                                          .galeryIndex >
                                                      count - 2
                                                  ? canDrag = false
                                                  : canDrag = true;
                                            }

                                            if (direction ==
                                                DismissDirection.startToEnd) {
                                              canDrag = true;
                                              context
                                                          .read<
                                                              UserPhotosModel>()
                                                          .galeryIndex <
                                                      1
                                                  ? canDrag = false
                                                  : canDrag = true;
                                            }
                                            setState() {}
                                            return canDrag;
                                          },
                                          onDismissed: (direction) {
                                            context
                                                .read<UserPhotosModel>()
                                                .photoGalleryDragUpdate2(
                                                    direction);
                                            setState() {}
                                          },
                                          key: ValueKey(listUrlsPhotos[context
                                              .watch<UserPhotosModel>()
                                              .galeryIndex]),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: FadeInImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(
                                                  listUrlsPhotos[context
                                                          .watch<
                                                              UserPhotosModel>()
                                                          .galeryIndex]
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
                                      ),
                                      Opacity(
                                        opacity: 0.5,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 70,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        height: 70,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.arrow_back,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 25),
                                            Text(
                                              '${context.watch<UserPhotosModel>().galeryIndex + 1} из $count',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      color: constants.backColor,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(listUrlsPhotos[index].toString()),
                        placeholder:
                            const AssetImage('assets/images/loading.gif'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          print(error); //do something
                          return Image.asset('assets/images/no-avatar.png');
                        },
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
