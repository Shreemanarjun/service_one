import 'package:dio/dio.dart';

abstract class IVendorProvider {
  Future<Response> getVendorService();
}
