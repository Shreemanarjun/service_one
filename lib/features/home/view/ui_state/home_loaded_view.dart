import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/features/home/controller/vendor_service_pod.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:service_one/features/home/view/widgets/date_time_btn.dart';
import 'package:service_one/features/home/view/widgets/header_image.dart';
import 'package:service_one/features/home/view/widgets/service_header_tile.dart';
import 'package:service_one/features/home/view/widgets/service_list.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeLoaded extends ConsumerWidget {
  final VendorModel vendorModel;
  const HomeLoaded({super.key, required this.vendorModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(vendorServicePod.future),
      child: <Widget>[
        HeaderImage(
          headerImageUrl: vendorModel.data.image_url,
        ).centered(),
        ServiceHeaderTile(
          vendorModel: vendorModel,
        ).py12(),
        Divider(
          thickness: 3,
          height: 4,
        ).py4(),
        "Choose Services"
            .text
            .lg
            .color(Color(0xffa0a0a0))
            .textStyle(TextStyle(
              fontWeight: FontWeight.w400,
            ))
            .makeCentered()
            .py(14),
        Divider(
          height: 1,
          thickness: 0.5,
        ).pOnly(
          top: 17,
          bottom: 15,
        ),
        ServiceList(
          vendorModel: vendorModel,
        ),
        Divider(
          height: 1,
          thickness: 0.5,
        ),
        PickDateTimeBtn().pOnly(
          left: 14,
          right: 14,
          top: 24,
        ),
      ]
          .vStack(
            crossAlignment: CrossAxisAlignment.stretch,
          )
          .scrollVertical(
            physics: ClampingScrollPhysics(),
          ),
    );
  }
}
