import 'package:flutter/material.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceHeaderTile extends StatelessWidget {
  const ServiceHeaderTile({
    super.key,
    required this.vendorModel,
  });

  final VendorModel vendorModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.webp',
          height: 44,
          width: 44,
        ).p8().flexible(),
        <Widget>[
          vendorModel.data.category_name.text.xl
              .textStyle(TextStyle(
                fontWeight: FontWeight.w700,
              ))
              .make()
              .objectTopLeft()
              .flexible(),
          vendorModel.data.description.text.sm
              .textStyle(TextStyle(
                color: Color(0xffa7a7a7),
                fontWeight: FontWeight.w400,
              ))
              .make()
              .objectTopLeft()
              .flexible(
                flex: 4,
              )
        ]
            .vStack(
              crossAlignment: CrossAxisAlignment.start,
            )
            .expand(flex: 4),
      ],
    );
  }
}
