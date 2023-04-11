import 'package:flutter/material.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceTileTitleText extends StatelessWidget {
  final Service service;
  const ServiceTileTitleText({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      service.service_name.text.black.lg
          .textStyle(TextStyle(
            fontWeight: FontWeight.w400,
          ))
          .make()
          .objectCenterLeft(),
      "${service.rate} SAR per unit"
          .text
          .green500
          .base
          .textStyle(TextStyle(
            fontWeight: FontWeight.w400,
          ))
          .make()
          .objectCenterLeft()
          .pOnly(
            top: 2,
            bottom: 8,
          ),
    ].vStack();
  }
}
