import 'package:dio/dio.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:service_one/data/provider/vendor/vendor_provider_pod.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:service_one/features/home/view/home_screen.dart';
import 'package:service_one/features/home/view/ui_state/home_loaded_view.dart';
import 'package:service_one/features/home/view/ui_state/home_loading_view.dart';
import 'package:service_one/features/home/view/widgets/header_image.dart';
import 'package:service_one/features/home/view/widgets/service_tile_trailing_btn.dart';

import '../../helpers/helpers.dart';
import '../controller/home_unit_test.dart';

class MockBaseCacheManager extends Mock implements BaseCacheManager {
  static const fileSystem = LocalFileSystem();
  @override
  Stream<FileResponse> getFileStream(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool? withProgress,
  }) async* {
    print(url);
    yield FileInfo(
      fileSystem.file('test/assets/logo.jpg'), // Return your image file path
      FileSource.Cache,
      DateTime(2050),
      url,
    );
  }
}

final vendorjson = """{
    "status": true,
    "message": "Fetched",
    "data": {
        "category_name": "Air Conditioner",
        "description": "Dummy description for Air conditioning",
        "image_url": "https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg",
        "services": [
            {
                "service_name": "Water leakage",
                "rate": 120,
                "description": "Leaking water",
                "image_url": "https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg"
            },
            {
                "service_name": "Split AC",
                "rate": 200,
                "description": "Service for split ac",
                "image_url": "https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg"
            },
            {
                "service_name": "Installation",
                "rate": 50,
                "description": "Installing AC",
                "image_url": "https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg"
            }
        ]
    }
}""";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('HomeView', () {
    testWidgets("render HomeLoading Page", (tester) async {
      final mockvendorprovider = MockVendorProvider();

      when(() => mockvendorprovider.getVendorService()).thenAnswer(
        (invocation) async => Response(
          requestOptions: RequestOptions(),
          data: VendorModel.fromJson(vendorjson).toMap(),
        ),
      );
      await tester.pumpApp(
        ProviderScope(
          overrides: [vendorProviderPod.overrideWithValue(mockvendorprovider)],
          child: HomeScreen(),
        ),
      );

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeLoadingView), findsOneWidget);
    });
    testWidgets("render HomeLoaded Page", (tester) async {
      final mockvendorprovider = MockVendorProvider();

      when(() => mockvendorprovider.getVendorService()).thenAnswer(
        (invocation) async => Response(
          requestOptions: RequestOptions(),
          data: VendorModel.fromJson(vendorjson).toMap(),
        ),
      );
      await tester.pumpApp(
        ProviderScope(
          overrides: [vendorProviderPod.overrideWithValue(mockvendorprovider)],
          child: HomeScreen(),
        ),
      );
      await tester.pump();
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeLoadingView), findsNothing);
      expect(find.byType(HomeLoaded), findsOneWidget);
      expect(find.byType(RefreshIndicator), findsOneWidget);
      expect(find.byType(HeaderImage), findsOneWidget);
      expect(find.byType(ServiceTileTrailingBtn), findsAtLeastNWidgets(3));
    });
    testWidgets("render Service Tile trailing button", (tester) async {
      final mockvendorprovider = MockVendorProvider();

      when(() => mockvendorprovider.getVendorService()).thenAnswer(
        (invocation) async => Response(
          requestOptions: RequestOptions(),
          data: VendorModel.fromJson(vendorjson).toMap(),
        ),
      );
      await tester.pumpApp(
        ProviderScope(
          overrides: [vendorProviderPod.overrideWithValue(mockvendorprovider)],
          child: HomeScreen(),
        ),
      );
      await tester.pump();
      expect(find.byType(ServiceTileTrailingBtn), findsAtLeastNWidgets(3));
      expect(find.byType(Text), findsAtLeastNWidgets(3));
      expect(find.text('Add'), findsAtLeastNWidgets(3));
      await tester.tap(find.text('Add').first);
      await tester.pump();
      expect(find.text('Added'), findsAtLeastNWidgets(1));
      await tester.tap(find.text('Added').first);
      await tester.pump();
      expect(find.text('Add'), findsAtLeastNWidgets(1));
    });
  });
}
