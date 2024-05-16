import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/db/interface/database_crud.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_repo.dart';
import 'package:inventory_management_app/shop/controller/shop_listbloc/shop_list_event.dart';
import 'package:inventory_management_app/shop/controller/shop_listbloc/shop_list_state.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  StreamSubscription? _onchangeSubscription;
  int currentoffset = 0;
  final SqlShopRepo shop;
  ShopListBloc(
    super.initialState,
    this.shop,
  ) {
    _onchangeSubscription = shop.onActions.listen(_shopRepoOnActionListener);
    on<ShopListCreatedEvent>(_shopListCreatedEventListener);
    on<ShopListUpdatedEvent>(_shopListUpdateEventListener);
    on<ShopListDeletedEvent>(_shoplistDeletedEventListener);
    on<ShopListGetEvent>(_shoplistgeteventlistener);
    add(ShopListGetEvent());
  }

  void _shopRepoOnActionListener(event) {
    final Result<DatabaseModel> shop = event.model;
    if (event.operations is DatabaseCrudCreateOperations) {
      add(ShopListCreatedEvent(shop.result! as Shop));
      return;
    }
    if (event.operations is DatabaseCrudUpdateOperations) {
      add(ShopListUpdatedEvent(shop.result! as Shop));
      return;
    }
    add(ShopListDeletedEvent(shop.result! as Shop));
  }

  FutureOr<void> _shoplistDeletedEventListener(event, emit) {
    final list = state.list.toList();
    list.remove(event.shop);
    emit(ShopListReceiveState(list));
  }

  FutureOr<void> _shopListUpdateEventListener(event, emit) {
    final list = state.list.toList();
    final index = list.indexOf(event.shop);
    list[index] = event.shop;
    emit(ShopListReceiveState(list));
  }

  FutureOr<void> _shopListCreatedEventListener(event, emit) {
    final list = state.list.toList();
    list.add(event.shop);
    emit(ShopListReceiveState(list));
  }

  FutureOr<void> _shoplistgeteventlistener(_, emit) async {
    if (state is ShopListLoadingState || state is ShopListSoftLoadingState) {
      return;
    }
    final list = state.list.toList();
    if (list.isEmpty) {
      emit(ShopListLoadingState(list));
    } else {
      emit(ShopListSoftLoadingState(list));
    }

    final result = await shop.findModel(offset: currentoffset);
    logger.i("shoplistgetevent $result ");
    if (result.hasError) {
      emit(ShopListErrorState(list, result.exception!.message));
    }
    final incominglist = result.result ?? [];
    if (incominglist.isEmpty) {
      emit(ShopListReceiveState(list));
      return;
    }

    currentoffset += incominglist.length;
    logger.i(incominglist);
    list.addAll(incominglist);

    emit(ShopListReceiveState(state.list.toList()));
  }

  @override
  Future<void> close() async {
    await _onchangeSubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}