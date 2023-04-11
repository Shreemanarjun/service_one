import 'package:flutter/material.dart';

import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceTileSubTitle extends StatelessWidget {
  final Service service;
  const ServiceTileSubTitle({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return service.description.text.sm
        .textStyle(TextStyle(
          color: Color(0xffa7a7a7),
          fontWeight: FontWeight.w400,
        ))
        .make();
  }
}
