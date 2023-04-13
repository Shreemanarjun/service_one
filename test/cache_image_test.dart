// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/features/home/view/widgets/header_image.dart';
import 'package:service_one/shared/pods/cache_manager_pod.dart';

import 'helpers/helpers.dart';
import 'home/view/home_test.dart';

Future<void> main() async {
  tearDown(() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });
  testWidgets('The image should be displayed', (tester) async {
    final container = makeProviderContainer(
      overrides: [
        defaultCacheManagerPod.overrideWithValue(DefaultMockCacheManager())
      ],
    );
    addTearDown(container.dispose);
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
            parent: container,
            child: MaterialApp(
              home: HeaderImage(
                headerImageUrl: 'dummy',
              ),
            )),
      );

      // Wait for the image to be loaded.
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pump();
      expect(find.byType(SuccessLogoImage), findsOneWidget);
      expect(find.byKey(ValueKey('success')), findsOneWidget);
    });
  });
  testWidgets('The error should be displayed', (tester) async {
    await tester.runAsync(() async {
      final container = ProviderContainer(
        overrides: [
          defaultCacheManagerPod
              .overrideWithValue(DefaultErrorMockCacheManager())
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        ProviderScope(
            parent: container,
            child: MaterialApp(
              home: HeaderImage(
                headerImageUrl: 'dummy',
              ),
            )),
      );

      // Wait for the image to be loaded.
      await Future<void>.delayed(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle(Duration(seconds: 10));
      await expectLater(find.byIcon(Icons.error), findsOneWidget);
    });
  });
}
