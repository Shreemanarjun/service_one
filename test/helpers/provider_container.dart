import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/logger.dart';
import 'package:service_one/observer.dart';

ProviderContainer makeProviderContainer({List<Override> overrides = const []}) {
  final container = ProviderContainer(
      overrides: overrides, observers: [MyObserverLogger(talker: talker)]);
  addTearDown(container.dispose);
  return container;
}
