import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:service_one/shared/dio_client/dio_client_pod.dart';

final vendorServicePod = FutureProvider.autoDispose<VendorModel>((ref) async {
  final response = await ref.watch(dioPod).get('testAPI');
  final vendomodel = VendorModel.fromMap(response.data);
  ref.keepAlive();
  return vendomodel;
});
