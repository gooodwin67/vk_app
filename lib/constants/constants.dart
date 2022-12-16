import 'package:flutter/material.dart';

class constants {
  static Color mainColor = Color.fromARGB(255, 38, 136, 235);
  static Color secondColor = Color.fromARGB(255, 71, 71, 71);
  static Color backColor = Color.fromARGB(255, 241, 241, 241);
  static double mainPadding = 15;
}

class DesctopOnlineIcon extends StatelessWidget {
  const DesctopOnlineIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(50),
        color: Color.fromARGB(255, 75, 179, 75),
      ),
      width: 17,
      height: 17,
    );
  }
}

class MobileOnlineIcon extends StatelessWidget {
  const MobileOnlineIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.phone_android_outlined,
        color: Color.fromARGB(255, 75, 179, 75),
        size: 15,
      ),
    );
  }
}
