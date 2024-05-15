import 'dart:convert';

import 'package:inventory_management_app/core/db/interface/crud_model.dart';

class Shop extends DatabaseModel {
  final String name, cover_photo;

  Shop({required super.id, required this.name, required this.cover_photo});

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "cover_photo": cover_photo,
    };
  }

  factory Shop.fromJson(dynamic data) {
    return Shop(
        id: data["id"], name: data["name"], cover_photo: data["cover_photo"]);
  }
  @override
  String toString() {
    return json.encode(toJson());
  }
}

class ShopParams extends DatabaseParamModel {
  final String name, cover_photo;

  ShopParams({required this.name, required this.cover_photo});
  factory ShopParams.toCreate({
    required String name,
    required String cover_photo,
  }) {
    return ShopParams(name: name, cover_photo: cover_photo);
  }
  factory ShopParams.toUpdate({
    String? name,
    String? cover_photo,
  }) {
    return ShopParams(name: name ?? "", cover_photo: cover_photo ?? "");
  }

  @override
  Map<String, dynamic> toCreate() {
    return {
      "name": name,
      "cover_photo": cover_photo,
    };
  }

  @override
  Map<String, dynamic> toUpdate() {
    assert(name.isNotEmpty || cover_photo.isNotEmpty);
    final Map<String, dynamic> payload = {};
    if (name.isNotEmpty) payload["name"] = name;
    if (cover_photo.isNotEmpty) payload["cover_photo"] = cover_photo;
    return payload;
  }
}
