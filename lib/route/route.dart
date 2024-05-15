import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_app/core/db/const/const.dart';
import 'package:inventory_management_app/core/impl/sqliteDatabase.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_bloc.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_state.dart';
import 'package:inventory_management_app/create%20_new_shop/screen/create_new_shop_screen.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_repo.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:inventory_management_app/shop/controller/shop_listbloc/shop_list_bloc.dart';
import 'package:inventory_management_app/shop/controller/shop_listbloc/shop_list_state.dart';
import 'package:inventory_management_app/shop/screen/shop_list_screen.dart';

Route route(RouteSettings settings) {
  switch (settings.name) {
    case (RouteNames.shopList):
      return _shoplist(const ShopListScreen(), settings);
    case (RouteNames.createNewShop):
      return _route(
          BlocProvider(
            create: (_) => CreateNewShopBloc(
                CreateNewShopInitialState(),
                ImagePicker(),
                SqlShopRepo(SqlliteDatabase.getInstance(shopDbName))),
            child: const CreateNewShopScreen(),
          ),
          settings);
    default:
      return _shoplist(const ShopListScreen(), settings);
  }
}

Route _shoplist(Widget child, RouteSettings settings) {
  return _route(
      BlocProvider(
        child: child,
        create: (_) => ShopListBloc(ShopListInitialState(),
            SqlShopRepo(SqlliteDatabase.getInstance(shopDbName))),
      ),
      settings);
}

Route _route(Widget child, RouteSettings settings) {
  return CupertinoPageRoute(
      builder: (_) {
        return child;
      },
      settings: settings);
}
