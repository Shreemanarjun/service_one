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
    return <Widget>[
      CachedNetworkImage(
        imageUrl: service.image_url,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      )
          .cornerRadius(8)
          .px24()
          .box
          .height(context.safePercentHeight * 8)
          .make()
          .flexible(),
      <Widget>[
        [
          ServiceTileTitleText(service: service).expand(flex: 3),
          Spacer(),
          ServiceTileTrailingBtn(
            service: service,
          )
              .box
              .height(24)
              .width(72)
              .make()
              .objectTopRight()
              .px8()
              .flexible(flex: 2)
        ]
            .hStack(crossAlignment: CrossAxisAlignment.start)
            .pOnly(top: 2)
            .flexible(),
        ServiceTileSubTitle(service: service).objectTopLeft().flexible(),
      ]
          .vStack(
            crossAlignment: CrossAxisAlignment.stretch,
            alignment: MainAxisAlignment.start,
          )
          .objectTopLeft()
          .expand(flex: 2),
    ].hStack(
      crossAlignment: CrossAxisAlignment.start,
    );
  }
}
