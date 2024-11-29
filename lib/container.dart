import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_app/core/bloc/custom_bloc_observer.dart';
import 'package:inventory_management_app/core/db/const/sql_table_const.dart';
import 'package:inventory_management_app/core/impl/sqliteDatabase.dart';
import 'package:inventory_management_app/core/injection/injection.dart';
import 'package:inventory_management_app/repo/shop_repo/sqlshop_repo.dart';

final Container container = Container();
Future<void> setUp() async {
  Bloc.observer = CustomBlocObserver();
  container.setLazy(() => SqlShopRepo(container.get<SqlliteDatabase>()));
  // container.setLazy(() => SqliteCategoryRepo(container.get<SqlliteDatabase>()));
  container.setLazy(() => ImagePicker());
  container.setSingletone(
      SqlliteDatabase.newInstance(shopDbName, shopTableColumn, 2));
  // final dbv1 = SqlliteDatabase.newInstance(
  //   "migrat_test_4",
  //   inventory_manangement_tableColumns,
  //   1,
  // );
  // await dbv1.connect();
  // await dbv1.close();
  // final dbv2 = SqlliteDatabase.newInstance(
  //   "migrat_test_4",
  //   inventory_manangement_tableColumns,
  //   2,
  // );
  // await dbv2.connect();
  // await dbv2.close();
  await container.get<SqlliteDatabase>().connect();
}
