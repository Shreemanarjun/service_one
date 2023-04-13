import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/features/home/controller/selected_service_list_pod.dart';
import 'package:service_one/features/home/view/widgets/date_time_btn.dart';

import 'helpers/helpers.dart';

void main() {
  late ProviderContainer container;
  setUp(() {
    container = makeProviderContainer();
  });
  tearDown(() {
    container.dispose();
  });
  testWidgets('Test PickDateTimeBtn Widget', (WidgetTester tester) async {
    addTearDown(() => container.dispose());
    // Build the PickDateTimeBtn widget
    await tester.pumpApp(
      ProviderScope(
        parent: container,
        child: MaterialApp(
          home: PickDateTimeBtn(),
        ),
      ),
    );

    expect(container.read(pickDateTimeBtnPressedPod), false);
    await tester.pump();
    await tester.tap(find.text('Proceed to Pick Date and Time'));
    expect(container.read(pickDateTimeBtnPressedPod), true);
  });
}
