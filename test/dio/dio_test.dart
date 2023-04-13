import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/shared/dio_client/dio_client_pod.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../helpers/helpers.dart';

void main() {
  group('dio test', () {
    test('dio instance', () {
      final container = makeProviderContainer();
      expect(container.read(dioPod), isA<Dio>());
    });
    test('dio base url test', () {
      final container = makeProviderContainer();
      expect(container.read(dioPod).options.baseUrl,
          'http://customer_server.maharah.neumtech.net/api/Vendors/');
    });
    test('dio base url test', () {
      final container = makeProviderContainer();
      expect(
        container.read(dioPod).options.headers,
        {
          'Authorization':
              'CIGfMA0GCSqGSIb3DQEBAQdqDup1pgSc0tQUMQUAA4GNADCBiQKBgQD3apAg6H2i',
        },
      );
    });
    test('dio talker inteceptor', () {
      final container = makeProviderContainer();
      expect(kReleaseMode, false);
      expect(Platform.environment.containsKey('FLUTTER_TEST'), true);
      expect(container.read(dioPod).interceptors.length, 2);
      expect(
          container.read(dioPod).interceptors.last,
          isA<TalkerDioLogger>()
              .having((s) => s.settings.printResponseHeaders,
                  "print responseheader to be true", true)
              .having((s) => s.settings.printRequestHeaders,
                  'print request header to be true', true));
    });
  });
}
