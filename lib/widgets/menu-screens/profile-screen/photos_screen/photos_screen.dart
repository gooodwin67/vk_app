import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/models/get_my_photos_model.dart';

class PhotosScreenWidget extends StatelessWidget {
  const PhotosScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List listUrlsPhotos = context.watch<MyPhotosModel>().urls;
    int count = context.watch<MyPhotosModel>().count;
    return Scaffold(
      body: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            childAspectRatio: 1,
          ),
          itemCount: count,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                context.read<MyPhotosModel>().photoGalleryInit(index);
                await showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      insetPadding: EdgeInsets.all(0),
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Dismissible(
                                    movementDuration: Duration(seconds: 0),
                                    resizeDuration: Duration(milliseconds: 100),
                                    confirmDismiss: (direction) async {
                                      return context
                                          .read<MyPhotosModel>()
                                          .canGaleryDrag;
                                    },
                                    onDismissed: (direction) {
                                      //print(direction);
                                      context
                                          .read<MyPhotosModel>()
                                          .photoGalleryDragUpdate2(direction);
                                      setState() {}
                                    },
                                    key: ValueKey(listUrlsPhotos[context
                                        .watch<MyPhotosModel>()
                                        .galeryIndex]),
                                    child: FadeInImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(listUrlsPhotos[context
                                              .watch<MyPhotosModel>()
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
                                Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
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
                                        '${context.watch<MyPhotosModel>().galeryIndex + 1} из $count',
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
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  imageErrorBuilder: (context, error, stackTrace) {
                    print(error); //do something
                    return Image.asset('assets/images/no-avatar.png');
                  },
                ),
              ),
            );
          }),
    );
  }
}
