import 'dart:io';

import 'package:inventory_management_app/core/db/const/const.dart';
import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/db/interface/table.dart';
import 'package:inventory_management_app/core/db/utils/table_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlliteDatabase extends DataStore<Database> {
  final String dbName;
  SqlliteDatabase._(this.dbName, [this.version = 1]);

  @override
  Database? database;
  final int version;
  static final Map<String, SqlliteDatabase?> _instance = {};
  static SqlliteDatabase newInstance(String dbName, [int version = 1]) {
    _instance[dbName] ??= SqlliteDatabase._(dbName, version);
    return _instance[dbName]!;
  }

  @override
  Future<void> OnDown([Database? db]) async {
    if (db == null) {
      assert(database != null);
    }

    // TODO: implement OnDown
    await Future.wait(tableNames.reversed.map((table) {
      return (db ?? database)!.execute("""
drop table if exists
      "$table"  
      """);
    }));
    print("Object delete");
  }

  @override
  Future<void> OnUp([Database? db]) async {
    if (db == null) {
      assert(database != null);
    }

    await Future.wait(tableNames.map((tableNames) {
      String query = '''Create table if not exists "$tableNames" (
        id integer primary key autoincrement,
        created_At text not null,
        updated_At text,
        ''';
      for (TableProperties columns in tableColumn[tableNames] ?? []) {
        query += toSqlQuery(columns);
      }
      query = query.replaceFirst(",", "", query.length - 2);
      query += ");";
      print("query is $query");
      return (db ?? database)!.execute(query);
    }));
    print("Object created");
  }

  @override
  Future<void> close() async {
    assert(database != null);
    await database!.close();
    _instance.remove(dbName);
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> connect() async {
    if (database != null) return;
    final Directory doc = await getApplicationCacheDirectory();
    final File dbFile = File("${doc.path}/$dbName");
    if (!(await dbFile.exists())) {
      dbFile.create();
    }
    database = await openDatabase(
      dbFile.path,
      version: version,
      onCreate: (db, __) async {
        await OnUp(db);
        print("reach");
      },
      onDowngrade: (db, __, ___) async {
        await OnDown(db);
      },
    );
    print("database $database");
  }
}
