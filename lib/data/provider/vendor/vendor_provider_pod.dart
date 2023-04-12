import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/data/provider/vendor/i_vendor_provider.dart';
import 'package:service_one/data/provider/vendor/vendor_provider.dart';
import 'package:service_one/shared/dio_client/dio_client_pod.dart';

final vendorProviderPod = Provider.autoDispose<IVendorProvider>((ref) {
  return VendorProvider(dio: ref.watch(dioPod));
});
