import 'dart:convert';

import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';

class Product extends DatabaseModel {
  Product({
    required this.name,
    required super.id,
    required this.category_id,
    required this.category,
    required this.barcode,
    required this.created_at,
    required this.updated_at,
    required this.description,
  });

  factory Product.fromJson(dynamic data) {
    print(
        "crated ${data['category_created_at'] != null} ${data['category_created_at']} ${data['category_name']}");
    Map<String, dynamic>? categoryPayload;
    final categoryId = int.parse(data['category_id'].toString());
    if (data['category_created_at'] != null) {
      categoryPayload = {};
      categoryPayload['id'] = categoryId;
      categoryPayload['name'] = data['category_name'];
      categoryPayload['created_at'] = data['category_created_at'];
      categoryPayload['updated_at'] = data['category_updated_at'];
    }
    print("cp $categoryPayload");
    return Product(
        name: data["name"],
        id: int.parse(data["id"].toString()),
        category_id: int.parse(data["category_id"].toString()),
        category: categoryPayload == null
            ? null
            : Category.fromJson(
                categoryPayload,
              ),
        barcode: data["barcode"],
        created_at: DateTime.parse(data["created_at"].toString()),
        description: data["description"],
        updated_at: DateTime.tryParse(data["updated_at"] ?? ""));
  }

  final String barcode;
  final Category? category;
  final int category_id;
  final DateTime created_at;
  final String description;
  final String name;
  final DateTime? updated_at;

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": int.parse(id.toString()),
      "category_id": category_id,
      "name": name,
      "category": category?.toJson(),
      "barcode": barcode,
      "created_at": created_at.toIso8601String(),
      "updated_at": updated_at?.toIso8601String(),
      "description": description,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class ProductParams extends DatabaseParamModel {
  ProductParams._(
      {required this.name,
      required this.category_id,
      required this.barcode,
      required this.description});

  factory ProductParams.created({
    required String name,
    required int category_id,
    required String barcode,
    String description = "",
  }) {
    return ProductParams._(
        name: name,
        category_id: category_id,
        barcode: barcode,
        description: description);
  }

  factory ProductParams.update(
    final String? name,
    final int? category_id,
    final String? barcode,
    String? description,
  ) {
    return ProductParams._(
        name: name ?? "",
        category_id: category_id ?? -1,
        barcode: barcode ?? "",
        description: description ?? "");
  }

  final String barcode;
  final int category_id;
  final String name;
  final String description;
  @override
  Map<String, dynamic> toCreate() {
    return {
      "category_id": category_id,
      "name": name,
      "barcode": barcode,
      "description": description,
    };
  }

  @override
  Map<String, dynamic> toUpdate() {
    assert(name.isNotEmpty || category_id > 0 || barcode.isNotEmpty);
    final Map<String, dynamic> payload = {};
    if (name.isNotEmpty == true) {
      payload["name"] = name;
    }
    if (category_id > 0) {
      payload["category_id"] = category_id;
    }
    if (barcode.isNotEmpty == true) {
      payload["barcode"] = barcode;
      if (description.isNotEmpty == true) {
        payload["description"] = description;
      }
    }

    return payload;
  }
}
