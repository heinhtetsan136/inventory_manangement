import 'dart:convert';

import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';

class Product extends DatabaseModel {
  final int id;
  final String name;
  final int category_id;
  final Categories? category;
  final String barcode;
  final DateTime created_At;
  final DateTime? updated_At;

  Product(
      {required this.name,
      required this.id,
      required this.category_id,
      required this.category,
      required this.barcode,
      required this.created_At,
      required this.updated_At});
  factory Product.fromJson(dynamic data) {
    print(
        "crated ${data['category_created_at'] != null} ${data['category_created_at']} ${data['category_name']}");
    Map<String, dynamic>? categoryPayload;
    final categoryId = int.parse(data['category_id'].toString());
    if (data['category_created_at'] != null) {
      categoryPayload = {};
      categoryPayload['id'] = categoryId;
      categoryPayload['name'] = data['category_name'];
      categoryPayload['created_At'] = data['category_created_at'];
      categoryPayload['updated_At'] = data['category_updated_at'];
    }
    print("cp $categoryPayload");
    return Product(
        name: data["name"],
        id: int.parse(data["id"].toString()),
        category_id: int.parse(data["category_id"].toString()),
        category: categoryPayload == null
            ? null
            : Categories.fromJson(
                categoryPayload,
              ),
        barcode: data["barcode"],
        created_At: DateTime.parse(data["created_At"].toString()),
        updated_At: DateTime.tryParse(data["updated_At"] ?? ""));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": int.parse(id.toString()),
      "category_id": category_id,
      "name": name,
      "category": category?.toJson(),
      "barcode": barcode,
      "created_At": created_At.toIso8601String(),
      "updated_At": updated_At?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class ProductParams extends DatabaseParamModel {
  final String name;
  final int category_id;

  final String barcode;

  ProductParams._(
      {required this.name, required this.category_id, required this.barcode});
  factory ProductParams.created(
    final String name,
    final int category_id,
    final String barcode,
  ) {
    return ProductParams._(
        name: name, category_id: category_id, barcode: barcode);
  }
  factory ProductParams.update(
    final String? name,
    final int? category_id,
    final String? barcode,
  ) {
    return ProductParams._(
        name: name ?? "",
        category_id: category_id ?? -1,
        barcode: barcode ?? "");
  }
  @override
  Map<String, dynamic> toUpdate() {
    final Map<String, dynamic> payload = {};
    if (name.isNotEmpty == true) {
      payload["name"] = name;
    }
    if (category_id > 0) {
      payload["category_id"] = category_id;
    }
    if (barcode.isNotEmpty == true) {
      payload["barcode"] = barcode;
    }

    return payload;
  }

  @override
  Map<String, dynamic> tocreate() {
    return {
      "category_id": category_id,
      "name": name,
      "barcode": barcode,
    };
  }
}
