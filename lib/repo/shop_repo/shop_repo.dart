import 'package:inventory_management_app/core/db/const/const.dart';
import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqlShopRepo extends sqliteRepo {
  SqlShopRepo(DataStore<Database> store) : super(store, Shop.fromJson, shopTb);
}
