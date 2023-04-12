import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/shared/pods/cache_manager_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class HeaderImage extends ConsumerWidget {
  const HeaderImage({
    super.key,
    required this.headerImageUrl,
  });

  final String headerImageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CachedNetworkImage(
      imageUrl: headerImageUrl,
      cacheManager: ref.watch(defaultCacheManagerPod),
      imageBuilder: (context, imageProvider) => SuccessLogoImage(
        imageProvider: imageProvider,
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator.adaptive(value: downloadProgress.progress)
              .centered(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

class SuccessLogoImage extends StatelessWidget {
  final ImageProvider<Object> imageProvider;
  const SuccessLogoImage({
    super.key,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.safePercentHeight * 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
