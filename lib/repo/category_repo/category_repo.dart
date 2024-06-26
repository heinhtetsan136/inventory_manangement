import 'package:inventory_management_app/core/db/const/sql_table_const.dart';
import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqliteCategoryRepo extends sqliteRepo<Category, CategoryParams> {
  SqliteCategoryRepo(
    DataStore<Database> store,
  ) : super.SqliteRepo(store, Category.fromJson, categoriesTb);
  @override
  // TODO: implement refQuery
  String get refQuery {
    return '''
   select "$tableName".*,
      (select count("$productTb"."id") 
      from "$productTb" where "$productTb"."category_id"="$tableName"."id") 
      as product_count 
      from "$tableName"

''';
  }
}
