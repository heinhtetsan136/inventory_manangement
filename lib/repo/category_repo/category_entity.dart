import 'dart:convert';

import 'package:inventory_management_app/core/db/interface/crud_model.dart';

class Categories extends DatabaseModel {
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? product_count;

  Categories(
      {required super.id,
      required this.product_count,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  factory Categories.fromJson(dynamic data) {
    print("crated At c ${DateTime.parse(data["created_At"])}");
    return Categories(
        product_count: int.tryParse(data["product_count"].toString() ?? ""),
        id: int.parse(data["id"].toString()),
        name: data["name"],
        createdAt: DateTime.parse(data["created_At"]),
        updatedAt: DateTime.tryParse(data["updated_At"] ?? ""));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "created_At": createdAt.toIso8601String(),
      "updated_At": updatedAt?.toIso8601String(),
      "product_count": product_count
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class CategoryParams implements DatabaseParamModel {
  final String name;

  CategoryParams._({required this.name});
  factory CategoryParams.create({required String name}) {
    return CategoryParams._(name: name);
  }
  factory CategoryParams.update({required String? name}) {
    return CategoryParams._(name: name ?? "");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }

  @override
  Map<String, dynamic> toCreate() {
    return {
      "name": name,
    };
  }

  @override
  Map<String, dynamic> toUpdate() {
    assert(name.isNotEmpty);
    final Map<String, dynamic> payload = {};
    if (name.isNotEmpty) payload["name"] = name;

    return payload;
  }
}
