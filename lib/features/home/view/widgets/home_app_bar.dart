import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: Icon(
        Icons.keyboard_backspace,
        size: 32,
      ),
      centerTitle: false,
      title: "Select Service"
          .text
          .textStyle(TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          ))
          .make(),
    );
  }
}
