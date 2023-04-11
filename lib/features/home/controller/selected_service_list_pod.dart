import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/features/home/controller/notifier/selected_service_list.dart';
import 'package:service_one/features/home/model/vendor_model.dart';

final selectedListServicePod =
    NotifierProvider.autoDispose<SelectedServiceListNotifier, List<Service>>(
        SelectedServiceListNotifier.new);

final isServiceAddedPod =
    Provider.family.autoDispose<bool, Service>((ref, service) {
  return ref.watch(
    selectedListServicePod.select(
      (value) => value.contains(service),
    ),
  );
});
