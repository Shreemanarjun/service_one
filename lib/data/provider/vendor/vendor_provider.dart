import 'package:dio/dio.dart';
import 'package:service_one/data/const/appurls.dart';

import 'i_vendor_provider.dart';

class VendorProvider implements IVendorProvider {
  final Dio dio;

  VendorProvider({required this.dio});
  @override
  Future<Response> getVendorService() {
    return dio.get(
      AppURLs.testAPIUrl,
    );
  }
}
