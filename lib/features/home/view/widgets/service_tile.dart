import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:service_one/features/home/view/widgets/service_tile_subtitle_text.dart';
import 'package:service_one/features/home/view/widgets/service_tile_title_text.dart';
import 'package:service_one/features/home/view/widgets/service_tile_trailing_btn.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: SizedBox.square(
        dimension: context.safePercentHeight * 8,
        child: CachedNetworkImage(
          imageUrl: service.image_url,
          fit: BoxFit.contain,
        ).cornerRadius(4),
      ),
      title: ServiceTileTitleText(service: service),
      subtitle: ServiceTileSubTitle(service: service),
      trailing: ServiceTileTrailingBtn(
        service: service,
      ).objectTopRight().box.height(32).width(72).make(),
    );
  }
}
