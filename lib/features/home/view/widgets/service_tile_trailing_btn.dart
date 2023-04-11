import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/features/home/controller/selected_service_list_pod.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceTileTrailingBtn extends ConsumerWidget {
  final Service service;
  const ServiceTileTrailingBtn({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isServiceAdded = ref.watch(isServiceAddedPod(service));
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isServiceAdded ? Color(0xffffb71b) : Color(0xfff0f0f0),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: (isServiceAdded ? "Added" : "Add")
          .text
          .sm
          .textStyle(TextStyle(
            fontFamily: 'SFProText',
            fontWeight: FontWeight.w400,
          ))
          .make(),
      onPressed: () {
        ref.read(selectedListServicePod.notifier).toggleAdd(service);
      },
    );
  }
}
