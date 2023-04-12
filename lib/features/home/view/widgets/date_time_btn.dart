import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PickDateTimeBtn extends StatelessWidget {
  const PickDateTimeBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.black,
          minimumSize: Size.fromHeight(44)),
      onPressed: null,
      child: "Proceed to Pick Date and Time"
          .text
          .textStyle(TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          ))
          .make(),
    );
  }
}
