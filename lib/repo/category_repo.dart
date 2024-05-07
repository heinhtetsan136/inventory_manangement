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
  Future<Category?> create(CategoryParams values) async {
    final payload = values.tocreate();
    final mapkey = payload.keys.map((e) {
      return " ${e.toString()}";
    });
    payload.addEntries({MapEntry("created_At", DateTime.now())});

    final insertedId = await database
        .rawInsert('''insert into "$tableName" (${payload.keys.join(",")}) 
        values (${payload.values.map((e) => "'$e'").join(",")})''');
    // final result = await database.insert(tableName, map);
    print("result $insertedId");
    return get(insertedId);

    // if (result.isEmpty) return null;
    // return Category.fromJson(result.first);
  }

  @override
  Future<Category?> delete() {
    throw UnimplementedError();
  }

  @override
  Future<Category?> update(int id, CategoryParams values) async {
    final payload = values.toUpdate();

    payload.addEntries({MapEntry("created_At", DateTime.now())});
    final dataset = payload.keys.map((column) {
      return "$column ='${payload[column]}'";
    }).join(",");
    final updatedId = await database
        .rawInsert('''update "$tableName" set $dataset where id = $id 
        ''');
    // final result = await database.insert(tableName, map);
    print("result $updatedId");
    return get(updatedId);
  }

  @override
  // TODO: implement database
  Database get database => store.database!;

  @override
  Future<Category?> get(int id) async {
    final result = await database
        .rawQuery("""select * from "$tableName" where id=$id limit 1""");
    print("get $result");
    return Category.fromJson(result.first);
  }

  @override
  Future<List<Category>?> find([int? limit = 1, int? offset = 0]) async {
    final result = await database
        .rawQuery("""select * from $tableName limit $offset,$limit """);
    return result.map((e) {
      return Category.fromJson(e);
    }).toList();
  }
}
