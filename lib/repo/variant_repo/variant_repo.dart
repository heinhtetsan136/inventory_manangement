import 'package:inventory_management_app/core/db/const/sql_table_const.dart';
import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';
import 'package:inventory_management_app/repo/variant_repo/variant_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqlVariantRepo extends sqliteRepo<Variant, VariantParams> {
  SqlVariantRepo(DataStore<Database> store)
      : super.SqliteRepo(store, Variant.fromJson, variantsTb);
}
