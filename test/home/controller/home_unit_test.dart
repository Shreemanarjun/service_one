import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/data/provider/vendor/i_vendor_provider.dart';
import 'package:service_one/data/provider/vendor/vendor_provider_pod.dart';
import 'package:service_one/features/home/controller/selected_service_list_pod.dart';
import 'package:service_one/features/home/controller/vendor_service_pod.dart';
import 'package:service_one/features/home/model/vendor_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockVendorProvider extends Mock implements IVendorProvider {}

void main() {
  group("SelectedServiceNotifier", () {
    test('initial state should be empty', () {
      final container = makeProviderContainer();
      expect(container.read(selectedListServicePod), equals([]));
    });
    test('add a new service', () {
      final container = makeProviderContainer();
      expect(container.read(selectedListServicePod), equals([]));
      final service = Service(
        service_name: 'AC Repair',
        rate: 120,
        description: "Ac repair service",
        image_url: 'http://google.com/logo.jpg',
      );
      container.read(selectedListServicePod.notifier).addService(service);
      expect(container.read(selectedListServicePod), equals([service]));
      expect(
        container.read(selectedListServicePod).first,
        isA<Service>()
            .having(
              (s) => s.service_name,
              "service name",
              service.service_name,
            )
            .having(
              (s) => s.rate,
              "service rate",
              service.rate,
            )
            .having(
              (s) => s.description,
              "service description",
              service.description,
            )
            .having(
              (s) => s.image_url,
              "service image",
              service.image_url,
            ),
      );
      expect(container.read(selectedListServicePod).length, equals(1));
    });
    test('remove a service', () {
      final container = makeProviderContainer();
      expect(container.read(selectedListServicePod), equals([]));
      final service = Service(
        service_name: 'AC Repair',
        rate: 120,
        description: "Ac repair service",
        image_url: '',
      );
      container.read(selectedListServicePod.notifier).addService(service);
      expect(container.read(selectedListServicePod), equals([service]));
      expect(container.read(selectedListServicePod).length, equals(1));
      container.read(selectedListServicePod.notifier).removeService(service);
      expect(container.read(selectedListServicePod), equals([]));
      expect(container.read(selectedListServicePod).length, equals(0));
    });
    test('toggle a service to remove', () {
      final container = makeProviderContainer();
      expect(container.read(selectedListServicePod), equals([]));
      final service = Service(
        service_name: 'AC Repair',
        rate: 120,
        description: "Ac repair service",
        image_url: '',
      );
      container.read(selectedListServicePod.notifier).addService(service);
      expect(container.read(selectedListServicePod), equals([service]));
      expect(container.read(selectedListServicePod).length, equals(1));
      container.read(selectedListServicePod.notifier).toggleAdd(service);
      expect(container.read(selectedListServicePod), equals([]));
      expect(container.read(selectedListServicePod).length, equals(0));
    });
    test('toggle a service to add', () {
      final container = makeProviderContainer();
      expect(container.read(selectedListServicePod), equals([]));
      final service = Service(
        service_name: 'AC Repair',
        rate: 120,
        description: "Ac repair service",
        image_url: '',
      );
      container.read(selectedListServicePod.notifier).toggleAdd(service);
      expect(container.read(selectedListServicePod), equals([service]));
      expect(container.read(selectedListServicePod).length, equals(1));
    });
  });

  test("is Service Add check on empty service", () {
    final container = makeProviderContainer();
    expect(container.read(selectedListServicePod), equals([]));
    final service = Service(
      service_name: 'AC Repair',
      rate: 120,
      description: "Ac repair service",
      image_url: 'http://google.com/logo.jpg',
    );
    container.read(selectedListServicePod.notifier).addService(service);
    expect(container.read(selectedListServicePod), equals([service]));
    expect(container.read(selectedListServicePod).length, equals(1));
    expect(container.read(isServiceAddedPod(service)), equals(true));
  });
  test("is Service Add check on filled service", () {
    final container = makeProviderContainer();
    expect(container.read(selectedListServicePod), equals([]));
    final service = Service(
      service_name: 'AC Repair',
      rate: 120,
      description: "Ac repair service",
      image_url: 'http://google.com/logo.jpg',
    );
    expect(container.read(selectedListServicePod).length, equals(0));
    expect(container.read(isServiceAddedPod(service)), equals(false));
  });
  test("vendorServicepod api success", () async {
    final mockvendorprovider = MockVendorProvider();
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
    final vendormodel = VendorModel.fromJson(vendorjson);
    when(() => mockvendorprovider.getVendorService()).thenAnswer(
      (invocation) async => Response(
        requestOptions: RequestOptions(),
        data: vendormodel.toMap(),
      ),
    );
    final container = makeProviderContainer(overrides: [
      vendorProviderPod.overrideWithValue(mockvendorprovider),
    ]);
    await container.read(vendorServicePod.future);
    expect(
        container.read(vendorServicePod),
        isA<AsyncData>()
            .having((s) => s.value, 'check vendor model', vendormodel));
  });

  test("vendorServicepod api failure", () async {
    final container = makeProviderContainer(
        overrides: [vendorServicePod.overrideWith((ref) => throw "error")]);

    await expectLater(
      await container.read(vendorServicePod),
      isA<AsyncError<VendorModel>>().having(
        (s) => s.error,
        'check vendor model',
        "error",
      ),
    );
  });
}
