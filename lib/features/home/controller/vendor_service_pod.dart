import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/data/provider/vendor/vendor_provider_pod.dart';
import 'package:service_one/features/home/model/vendor_model.dart';

final vendorServicePod = FutureProvider.autoDispose<VendorModel>((ref) async {
  final response = await ref.watch(vendorProviderPod).getVendorService();
  final vendomodel = VendorModel.fromMap(response.data);
  ref.keepAlive();
  return vendomodel;
});
