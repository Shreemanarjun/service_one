import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_one/logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final dioPod = Provider.autoDispose<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://customer_server.maharah.neumtech.net/api/Vendors/',
    headers: {
      'Authorization':
          'CIGfMA0GCSqGSIb3DQEBAQdqDup1pgSc0tQUMQUAA4GNADCBiQKBgQD3apAg6H2i',
    },
  ));
  if (kDebugMode && !Platform.environment.containsKey('FLUTTER_TEST')) {
    dio.interceptors.add(TalkerDioLogger(
        talker: talker,
        settings: TalkerDioLoggerSettings(
          printResponseHeaders: true,
          printRequestHeaders: true,
        )));
  }
  return dio;
});
