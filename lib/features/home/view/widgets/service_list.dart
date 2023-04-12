import 'package:flutter/material.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:service_one/features/home/view/widgets/service_tile.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({
    super.key,
    required this.vendorModel,
  });

  final VendorModel vendorModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: vendorModel.data.services.length,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          thickness: 1,
        ).pSymmetric(v: 8);
      },
      itemBuilder: (context, index) {
        final service = vendorModel.data.services[index];
        return ServiceTile(service: service);
      },
    );
  }
}
