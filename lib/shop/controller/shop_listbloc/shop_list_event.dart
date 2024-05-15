import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';

abstract class ShopListEvent {
  const ShopListEvent();
}

class ShopListGetEvent extends ShopListEvent {
  ShopListGetEvent();
}

class ShopListCreatedEvent extends ShopListEvent {
  final Shop shop;
  ShopListCreatedEvent(this.shop);
}

class ShopListUpdatedEvent extends ShopListEvent {
  final Shop shop;
  ShopListUpdatedEvent(this.shop);
}

class ShopListDeletedEvent extends ShopListEvent {
  final Shop shop;
  ShopListDeletedEvent(this.shop);
}
