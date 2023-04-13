import 'package:flutter_test/flutter_test.dart';
import 'package:service_one/features/home/model/vendor_model.dart';

import '../view/home_test.dart';

void main() {
  group(
    'vendor model test',
    () {
      test("check equality", () {
        final vendormodel = VendorModel.fromJson(vendorjson);
        final testvendormodel = VendorModel(
          status: true,
          message: 'Fetched',
          data: Category(
            category_name: 'Air Conditioner',
            description: 'Dummy description for Air conditioning',
            image_url:
                "https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg",
            services: [
              Service(
                service_name: 'Water leakage',
                rate: 120,
                description: 'Leaking water',
                image_url:
                    'https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg',
              ),
              Service(
                service_name: 'Split AC',
                rate: 200,
                description: 'Service for split ac',
                image_url:
                    'https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg',
              ),
              Service(
                service_name: 'Installation',
                rate: 50,
                description: 'Installing AC',
                image_url:
                    'https://maharah-app-images.s3.amazonaws.com/DefaultImages/default.jpg',
              ),
            ],
          ),
        );
        expect(
          vendormodel,
          testvendormodel,
        );
        expect(vendormodel.status, testvendormodel.status);
        expect(vendormodel.message, testvendormodel.message);
        expect(vendormodel.data, vendormodel.data);
        expect(
          vendormodel.data.category_name,
          testvendormodel.data.category_name,
        );
        expect(
          vendormodel.data.description,
          testvendormodel.data.description,
        );
        expect(
          vendormodel.data.image_url,
          testvendormodel.data.image_url,
        );
        expect(
            vendormodel.hashCode,
            vendormodel.status.hashCode ^
                vendormodel.message.hashCode ^
                vendormodel.data.hashCode);
      });
    },
  );
}
