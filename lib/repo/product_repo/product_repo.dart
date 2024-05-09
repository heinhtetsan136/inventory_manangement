import 'package:inventory_management_app/core/db/const/const.dart';
import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';
import 'package:inventory_management_app/repo/product_repo/product_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqlProductRepo extends sqliteRepo<Product, ProductParams> {
  SqlProductRepo(DataStore<Database> store)
      : super(store, Product.fromJson, productTb);
  @override
  // TODO: implement refQuery
  String get refQuery {
    return '''
      select "$tableName".*,
      "$categoriesTb".name as categories_name,
      "$categoriesTb".created_At as categories_created_At

       from "$tableName"  join  "$categoriesTb" on 
       "$categoriesTb"."id" = "$tableName"."category_id" 
    ''';
  }
}
