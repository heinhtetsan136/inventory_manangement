import 'dart:io';

import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/db/interface/table.dart';
import 'package:inventory_management_app/core/db/utils/table_utils.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlliteDatabase extends DataStore<Database> {
  final String dbName;
  final String storePath;
  final Map<int, Map<String, List<TableProperties>>> tableColumns;

  SqlliteDatabase._(this.dbName, this.tableColumns, [this.version = 1])
      : storePath = "/sqlite";

  @override
  Database? database;
  final int version;
  Directory? doc;
  static final Map<String, SqlliteDatabase?> _instance = {};
  static SqlliteDatabase newInstance(
      String dbName, Map<int, Map<String, List<TableProperties>>> tableColumns,
      [int version = 1]) {
    assert(_instance[dbName] == null);
    _instance[dbName] ??= SqlliteDatabase._(
      dbName,
      tableColumns,
      version,
    );
    return _instance[dbName]!;
  }

  static SqlliteDatabase getInstance(String dbName) {
    return _instance[dbName]!;
  }

  @override
  Future<void> OnUp(
    int version, [
    Database? db,
  ]) async {
    assert(db != null || database != null);

    final columnMigration = tableColumns[version];
    if (columnMigration == null) throw "version not found";

    await Future.wait(columnMigration.keys.map((tableName) {
      String query = """Create table if not exists "$tableName" (
        id integer primary key autoincrement,
        created_at text not null,  
        updated_at text,
      """;

      ///other column
      for (TableProperties column in columnMigration[tableName] ?? []) {
        query += toSqlQuery(column);
      }

      /// Create table if not exists $tableName (
      ///  id integer primary key autoincrement,
      ///  created_at text not null,
      ///  updated_at text,
      ///  name varchar(255) not null,
      ///  length > index  > 1
      ///  2
      query = query.replaceFirst(",", "", query.length - 2);

      /// Create table if not exists $tableName (
      ///  id integer primary key autoincrement,
      ///  created_at text not null,
      ///  updated_at text,
      ///  name varchar(255) not null

      query += ");";
      return (db ?? database)!.execute(query);
    }));
  }

  @override
  Future<void> OnDown(int old, current, [Database? db]) async {
    assert(db != null || database != null);
    final currentMigration = tableColumns[current];
    if (currentMigration == null) throw "version now found";
    final oldColumnMigration = tableColumns[old];
    if (oldColumnMigration == null) {
      throw "version not found";
    }
    await Future.wait(currentMigration.keys.toList().reversed.map((e) {
      return (db ?? database)!.execute("""
        drop table if exists "$e"; 
      """);
    }));

    // await onUp(current, db);
  }

  @override
  Future<void> close() async {
    logger.i("database sql close");
    print("database close ${database == null}");
    assert(database != null);
    await database!.close();
    _instance.remove(dbName);
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<Result> connect() async {
    print("database ${database != null}");
    logger.i("database sql created");
    if (database != null) return Result(result: database);
    try {
      await checkStorePath();
      final File dbFile = File("${doc!.path}/$dbName");
      if (!(await dbFile.exists())) {
        print("object");
        dbFile.create();
      }
      database = await openDatabase(
        dbFile.path,
        version: version,
        onConfigure: (db) {
          database = db;
        },
        onCreate: (db, version) async {
          await OnUp(version, db);
          print("reach");
        },
        onDowngrade: (db, old, current) async {
          await OnDown(old, current, db);
        },
      );
      print("database $database");
      return Result(result: database);
    } catch (e) {
      return Result(
          exception: ResultException(
        e.toString(),
      ));
    }
  }

  Future<void> checkStorePath() async {
    if (doc == null) {
      doc = await getApplicationDocumentsDirectory();
      doc = Directory(doc!.path + storePath);
      if (await doc!.exists()) return;

      await doc!.create();
    }
  }

  Future<void> removeAllSqliteFile() async {
    if (doc == null) {
      await checkStorePath();
    }

    await doc!.list().forEach((fs) async {
      final sta = await fs.stat();
      if (sta.type == FileSystemEntityType.file) {
        print("sqlfile ${fs.path} ${fs.toString()} deleted");
        await fs.delete();
      }
    });
  }
}
