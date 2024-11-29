import 'package:inventory_management_app/core/db/interface/crud_model.dart';

class Variant extends DatabaseModel {
  final int productID;
  final String coverPhoto;
  final String sku;
  final double price;
  final double available, onHand, lost, damage;
  final bool allowPurchaseWhenOutOfStock;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<Variant> variant;

  const Variant(
      {required super.id,
      required this.variant,
      required this.productID,
      required this.coverPhoto,
      required this.sku,
      required this.price,
      required this.available,
      required this.onHand,
      required this.lost,
      required this.damage,
      required this.allowPurchaseWhenOutOfStock,
      required this.createdAt,
      required this.updatedAt});
  factory Variant.fromJson(dynamic data) {
    return Variant(
      id: int.parse(data['id'].toString()),
      productID: int.parse(data['product_id'].toString()),
      coverPhoto: data['cover_photo'],
      sku: data['sku'].toString(),
      price: double.parse(data['price'].toString()),
      available: double.parse(data['available'].toString()),
      damage: double.parse(data['damage'].toString()),
      onHand: double.parse(data['on_hand'].toString()),
      lost: double.parse(data['lost'].toString()),
      allowPurchaseWhenOutOfStock:
          data['allow_purchase_when_out_of_stock'] == true,
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.tryParse(data['updated_at'] ?? ""),
      variant: [],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "product_id": productID,
      "cover_photo": coverPhoto,
      "sku": sku,
      "price": price,
      "avaiable": available,
      "onHand": onHand,
      "lost": lost,
      "damage": damage,
      "allow_purchase_when_out_of_stock": allowPurchaseWhenOutOfStock,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}

class VariantParams extends DatabaseParamModel {
  int? productID;
  final String coverPhoto;
  final String sku;
  final double price;
  final double available, onHand, lost, damage;
  final bool? allowPurchaseWhenOutOfStock;

  VariantParams._(
      {required this.coverPhoto,
      required this.sku,
      required this.price,
      required this.available,
      required this.onHand,
      required this.lost,
      required this.damage,
      required this.allowPurchaseWhenOutOfStock});
  VariantParams.toCreate({
    required this.coverPhoto,
    required this.sku,
    required this.price,
    required this.available,
    required this.onHand,
    required this.lost,
    required this.damage,
    required this.allowPurchaseWhenOutOfStock,
  }) : assert(allowPurchaseWhenOutOfStock != null);

  VariantParams.toUpdate({
    this.coverPhoto = "",
    this.sku = "",
    this.price = -1,
    this.available = -1,
    this.onHand = -1,
    this.lost = -1,
    this.damage = -1,
    this.allowPurchaseWhenOutOfStock,
  }) : productID = -1;
  @override
  Map<String, dynamic> toCreate() {
    assert(productID != null);
    return {
      "product_id": productID,
      "cover_photo": coverPhoto,
      "sku": sku,
      "price": price,
      "available": available,
      "on_hand": onHand,
      "damage": damage,
      "lost": lost,
      "allow_purchase_when_out_of_stock": allowPurchaseWhenOutOfStock == true,
    };
  }

  @override
  Map<String, dynamic> toUpdate() {
    final Map<String, dynamic> payload = {};
    if (coverPhoto.isNotEmpty) {
      payload.addEntries({MapEntry("cover_photo", coverPhoto)});
    }
    if (sku.isNotEmpty) {
      payload.addEntries({MapEntry("sku", sku)});
    }
    if (price >= 0) {
      payload.addEntries({MapEntry("price", price)});
    }
    if (available >= 0) {
      payload.addEntries({MapEntry("available", available)});
    }
    if (onHand >= 0) {
      payload.addEntries({MapEntry("on_hand", onHand)});
    }
    if (damage >= 0) {
      payload.addEntries({MapEntry("damage", damage)});
    }
    if (lost >= 0) {
      payload.addEntries({MapEntry("lost", lost)});
    }
    if (allowPurchaseWhenOutOfStock != null) {
      payload.addEntries({
        MapEntry(
            "allow_purchase_when_out_of_stock", allowPurchaseWhenOutOfStock)
      });
    }
    return payload;
  }
}
