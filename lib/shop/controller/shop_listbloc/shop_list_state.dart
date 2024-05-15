import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';

abstract class ShopListState {
  final List<Shop> list;
  final DateTime _dateTime;
  ShopListState(this.list) : _dateTime = DateTime.now();
  @override
  bool operator ==(covariant ShopListState other) {
    return other._dateTime.toIso8601String() == _dateTime.toIso8601String();
  }

  @override
  // TODO: implement hashCode
  int get hashCode => _dateTime.hashCode;
}

class ShopListInitialState extends ShopListState {
  ShopListInitialState([List<Shop> shop = const []]) : super(shop);
}

class ShopListReceiveState extends ShopListState {
  ShopListReceiveState(super.list);
}

class ShopListErrorState extends ShopListState {
  final String message;
  ShopListErrorState(super.list, this.message);
}

class ShopListLoadingState extends ShopListState {
  ShopListLoadingState(super.list);
}

class ShopListSoftLoadingState extends ShopListState {
  ShopListSoftLoadingState(super.list);
}
