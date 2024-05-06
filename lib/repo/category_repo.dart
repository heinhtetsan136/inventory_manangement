import 'package:inventory_management_app/core/db/const/const.dart';
import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/db/interface/database_crud.dart';
import 'package:inventory_management_app/repo/category_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqlCategoryRepo
    implements DatabaseCrud<Database, Category, CategoryParams> {
  @override
  final DataStore<Database> store;
  @override
  final String tableName;
  SqlCategoryRepo(this.store) : tableName = categoriesTb;
  @override
  Future<Category?> create(CategoryParams params) async {
    final map = params.toJson();
    map.addEntries({MapEntry("created_At", DateTime.now().toIso8601String())});
    final result = await database
        .rawInsert("""insert into $tableName (${map.keys.join(",")}) 
        values (${map.values.map((e) => "$e").join(",")}) ;""");
    print("result $result");
    return null;

    // if (result.isEmpty) return null;
    // return Category.fromJson(result.first);
  }

  @override
  Future<Category?> delete() {
    throw UnimplementedError();
  }

  @override
  Future<Category?> update() {
    throw UnimplementedError();
  }

  @override
  // TODO: implement database
  Database get database => store.database!;
}
