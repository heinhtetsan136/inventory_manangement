import 'package:inventory_management_app/core/db/interface/crud_model.dart';

class Category {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  factory Category.fromJson(dynamic data) {
    return Category(
        id: int.parse(data["id"].toString()),
        name: data["name"],
        createdAt: DateTime.parse(data["crated_At"].toString()),
        updatedAt: DateTime.parse(data["updated_At"].toString() ?? ""));
  }
}

class CategoryParams implements DatabaseModel {
  final String name;

  CategoryParams({required this.name});

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}
