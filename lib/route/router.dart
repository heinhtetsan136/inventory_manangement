import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_app/category/controller/category_list_bloc.dart';
import 'package:inventory_management_app/category/view/add_category_screen.dart';
import 'package:inventory_management_app/container.dart';
import 'package:inventory_management_app/core/bloc/sql_read_state.dart';
import 'package:inventory_management_app/core/db/const/sql_table_const.dart';
import 'package:inventory_management_app/core/impl/sqliteDatabase.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_form.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_form_bloc.dart';
import 'package:inventory_management_app/create%20_new_shop/screen/create_new_shop_screen.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_form.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_form_bloc.dart';
import 'package:inventory_management_app/create_new_category/screen/create_new_category_screen.dart';
import 'package:inventory_management_app/create_new_product/controller/create_new_product_bloc.dart';
import 'package:inventory_management_app/create_new_product/controller/create_product_form.dart';
import 'package:inventory_management_app/create_new_product/screen/create_new_product_screen.dart';
import 'package:inventory_management_app/create_new_product/screen/set_product_inventory_screen.dart';
import 'package:inventory_management_app/create_new_product/screen/set_product_price_screen.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_engine/dasgboard_engine_state.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_engine/dashboard_engine_bloc.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_navigation/dashboard_navigation_bloc.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_navigation/dashboard_navigation_state.dart';
import 'package:inventory_management_app/dashboard/screen/dashboard_loader_screen.dart';
import 'package:inventory_management_app/dashboard/screen/dashboard_screen.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';
import 'package:inventory_management_app/repo/category_repo/category_repo.dart';
import 'package:inventory_management_app/repo/dashboard/dashboard_repo.dart';
import 'package:inventory_management_app/repo/product_repo/product_repo.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';
import 'package:inventory_management_app/repo/shop_repo/sqlshop_repo.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:inventory_management_app/shop/controller/shop_listbloc/shop_list_bloc.dart';
import 'package:inventory_management_app/shop/screen/shop_list_screen.dart';

final Map<String, Route Function(RouteSettings settings)> route = {
  RouteNames.shopList: (settings) {
    return _shoplist(settings);
  },
  RouteNames.dashboardloader: (settings) {
    final arg = settings.arguments;
    logger.i(container.exists<DashBoardEngineBloc>());

    if (arg is! String) return _route(ErrorWidget("BadRequest"), settings);
    logger.e("arg is  ${arg.toString()}");
    if (container.exists<DashBoardEngineBloc>()) {
      print("contrainer route true");
      return _route(
          BlocProvider.value(
            value: container.get<DashBoardEngineBloc>(),
            child: const DashBoardLoader(),
          ),
          settings);
    }
    print("container route false");
    return _route(
        BlocProvider(
          create: (_) {
            container.set(
              DashBoardEngineBloc(
                  const DashboardEngineInitialState(),
                  DashBoardEngineRepo(
                      shopName: arg,
                      database: SqlliteDatabase.newInstance(
                          arg, inventory_manangement_tableColumns, 3))),
            );

            return container.get<DashBoardEngineBloc>();
          },
          child: const DashBoardLoader(),
        ),
        settings);
  },
  RouteNames.createNewShop: (settings) {
    return _route(
        BlocProvider(
          create: (_) => CreateNewShopFormBloc(container.get<SqlShopRepo>(),
              ShopCreateForm.createForms(), container.get<ImagePicker>()),
          child: const CreateNewShopScreen(),
        ),
        settings);
    // BlocProvider(
    //   create: (_) => CreateNewShopBloc(CreateNewShopInitialState(),
    //       container.get<ImagePicker>(), container.get<SqlShopRepo>()),
    //   child: const CreateNewShopScreen(),
    // ),
    // settings);
  },
  RouteNames.dashboard: (settings) {
    if (!container.exists<DashBoardEngineBloc>()) {
      return _shoplist(settings);
    }
    return _route(
        MultiBlocProvider(providers: [
          BlocProvider(
              create: (_) => CategoryListBloc(SqliteInitialState(<Category>[]),
                  container.get<SqliteCategoryRepo>())),
          BlocProvider.value(value: container.get<DashBoardEngineBloc>()),
          BlocProvider(
              create: (_) =>
                  DashBoardNavigationBloc(DashboardNavigationSate(0)))
        ], child: const DashBoardScreen()),
        settings);
  },
  RouteNames.createNewCategory: (settings) {
    return _route(
        BlocProvider(
          child: const CreateNewCategoryScreen(),
          create: (_) => CreateNewCategoryFormBloc(
            container.get<SqliteCategoryRepo>(),
            CreateNewCategoryForm.form(),
          ),
        ),
        settings);
  },
  RouteNames.createNewProduct: (settings) {
    final value = settings.arguments;
    if (value is! CategoryListBloc) {
      return _route(ErrorWidget("CategoryListBloc Not Found"), settings);
    }
    return _route(
        MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => CreateNewProductBloc(
                    container.get<SqlProductRepo>(),
                    CreateProductForm.form(),
                    container.get<ImagePicker>())),
            BlocProvider.value(value: value)
          ],
          child: const CreateNewProductScreen(),
        ),
        settings);
  },
  RouteNames.addCategoryScreen: (settings) {
    final bloc = settings.arguments;
    if (bloc is! CategoryListBloc) {
      return _route(ErrorWidget("CategoryListBloc not found"), settings);
    }
    return _route(
        BlocProvider.value(value: bloc, child: const AddCategoryScreen()),
        settings);
  },
  RouteNames.setProductPriceScreen: (settings) {
    final bloc = settings.arguments;
    if (bloc is! CreateNewProductBloc) {
      return _route(ErrorWidget("CreateNewProductBloc not found"), settings);
    }
    return _route(
        BlocProvider.value(value: bloc, child: const SetProductPriceScreen()),
        settings);
  },
  RouteNames.setProductInventory: (settings) {
    final bloc = settings.arguments;
    if (bloc is! CreateNewProductBloc) {
      return _route(ErrorWidget("CreateNewProductBloc not found"), settings);
    }
    return _route(
        BlocProvider.value(
            value: bloc, child: const SetProductInventoryScreen()),
        settings);
  }
};
Route router(RouteSettings settings) {
  return route[settings.name]?.call(settings) ?? _shoplist(settings);
}

Route _shoplist(RouteSettings settings) {
  return _route(
      BlocProvider(
        child: const ShopListScreen(),
        create: (_) => ShopListBloc(
            SqliteInitialState<Shop>(<Shop>[]), container.get<SqlShopRepo>()),
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
