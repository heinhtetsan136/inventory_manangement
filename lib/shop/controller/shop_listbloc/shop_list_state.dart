import 'package:inventory_management_app/core/bloc/basic_state.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';

abstract class ShopListState extends BasicState {
  final List<Shop> list;
  ShopListState(this.list);
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
