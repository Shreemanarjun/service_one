import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/shared/riverpod_ext/async_value_easy_when.dart';

void main() {
  testWidgets('Test DefaultErrorWidget', (WidgetTester tester) async {
    // Create an AsyncError with some error and stackTrace
    final asyncError = AsyncError<Object>('Async Error', StackTrace.current);

    // Build the DefaultErrorWidget with the error and stackTrace
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: DefaultErrorWidget(
            error: asyncError.error,
            stackTrace: asyncError.stackTrace,
            onRetry: null,
            isLinear: true,
          ),
        ),
      ),
    );

    // Find the ErrorTextWidget
    final errorTextFinder = find.textContaining('Async Error');

    // Verify that the ErrorTextWidget displays the error message
    expect(
      tester.widget<Text>(errorTextFinder.first),
      isA<Text>().having(
          (s) => s.data, 'async error text', asyncError.error.toString()),
    );

    // Find the ElevatedButton
    final elevatedButtonFinder = find.byType(Text);

    // Verify that the ElevatedButton has the correct child text
    expect(
      tester.widget<Text>(elevatedButtonFinder.last).data,
      equals('Try Again later.'),
    );

    // Tap the ElevatedButton
    await tester.tap(elevatedButtonFinder.last);
    await tester.pump();
  });
}
