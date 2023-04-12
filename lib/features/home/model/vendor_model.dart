import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class VendorModel {
  final bool status;
  final String message;
  final Category data;
  VendorModel({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      data: Category.fromMap(map['data']),
    );
  }

  factory VendorModel.fromJson(String source) =>
      VendorModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendorModel &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class Category {
  final String category_name;
  final String description;
  final String image_url;
  final List<Service> services;
  Category({
    required this.category_name,
    required this.description,
    required this.image_url,
    required this.services,
  });

  Map<String, dynamic> toMap() {
    return {
      'category_name': category_name,
      'description': description,
      'image_url': image_url,
      'services': services.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      category_name: map['category_name'] ?? '',
      description: map['description'] ?? '',
      image_url: map['image_url'] ?? '',
      services:
          List<Service>.from(map['services']?.map((x) => Service.fromMap(x))),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.category_name == category_name &&
        other.description == description &&
        other.image_url == image_url &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode {
    return category_name.hashCode ^
        description.hashCode ^
        image_url.hashCode ^
        services.hashCode;
  }
}

class Service {
  final String service_name;
  final int rate;
  final String description;
  final String image_url;
  Service({
    required this.service_name,
    required this.rate,
    required this.description,
    required this.image_url,
  });

  Map<String, dynamic> toMap() {
    return {
      'service_name': service_name,
      'rate': rate,
      'description': description,
      'image_url': image_url,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      service_name: map['service_name'] ?? '',
      rate: map['rate']?.toInt() ?? 0,
      description: map['description'] ?? '',
      image_url: map['image_url'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
        other.service_name == service_name &&
        other.rate == rate &&
        other.description == description &&
        other.image_url == image_url;
  }

  @override
  int get hashCode {
    return service_name.hashCode ^
        rate.hashCode ^
        description.hashCode ^
        image_url.hashCode;
  }
}
