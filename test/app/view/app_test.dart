import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/app/app.dart';
import 'package:service_one/features/home/view/home_screen.dart';
import 'package:service_one/features/home/view/widgets/home_app_bar.dart';

void main() {
  group('App', () {
    testWidgets('renders Select HomePage', (tester) async {
      await tester.pumpWidget(ProviderScope(
        child: const App(),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
    testWidgets('renders AppBar', (tester) async {
      await tester.pumpWidget(ProviderScope(
        child: const App(),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(HomeAppBar), findsOneWidget);
      expect(find.text("Select Service"), findsOneWidget);
    });
  });
}
