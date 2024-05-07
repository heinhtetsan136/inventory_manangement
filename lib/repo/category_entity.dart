import 'dart:convert';

import 'package:inventory_management_app/core/db/interface/crud_model.dart';

class Category {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Category(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  factory Category.fromJson(dynamic data) {
    return Category(
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
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class CategoryParams implements DatabaseModel {
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
  Map<String, dynamic> toUpdate() {
    return {
      "name": name,
    };
  }

  @override
  Map<String, dynamic> tocreate() {
    final Map<String, dynamic> data = {};
    if (name.isNotEmpty) data["name"] = name;
    return data;
  }
}
