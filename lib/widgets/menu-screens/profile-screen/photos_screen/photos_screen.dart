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
                await showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: Container(
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
                              child: FadeInImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    listUrlsPhotos[index].toString()),
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
                          ],
                        ),
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
