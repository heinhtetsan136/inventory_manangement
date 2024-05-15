import 'dart:async';

import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/db/interface/database_crud.dart';
import 'package:sqflite/sqflite.dart';

class sqliteRepo<Model extends DatabaseModel,
        ModelParams extends DatabaseParamModel>
    implements DatabaseCrud<Database, Model, ModelParams> {
  @override
  final DataStore<Database> store;
  @override
  final String tableName;
  final Model Function(dynamic data) parser;
  sqliteRepo(this.store, this.parser, this.tableName);
  final StreamController<DatabaseCrudOnchange> _streamController =
      StreamController.broadcast();

  @override
  Future<Result<Model>> create(ModelParams values) async {
    final payload = values.toCreate();
    final mapkey = payload.keys.map((e) {
      return " ${e.toString()}";
    });
    payload.addEntries({MapEntry("created_At", DateTime.now())});

    final insertedId = await database
        .rawInsert('''insert into "$tableName" (${payload.keys.join(",")}) 
        values (${payload.values.map((e) => "'$e'").join(",")})''');
    // final result = await database.insert(tableName, map);
    print("result $insertedId");

    final model = await getOne(insertedId);
    _streamController.sink.add(DatabaseCrudOnchange.DatabaseCrudOnActions(
        model: model, operations: DatabaseCrudCreateOperations()));
    return model;

    // if (result.isEmpty) return null;
    // return Category.fromJson(result.first);
  }

  @override
  Future<Result<Model>> delete(int id) async {
    final model = await _get(id);
    final int effectedrow = await database
        .rawDelete("""delete from "$tableName" where id =?""", [id]);
    if (effectedrow < 1) {
      return Result(
          exception: ResultException("failed to delete", StackTrace.current));
    }
    print("detleted $effectedrow");
    _streamController.sink.add(DatabaseCrudOnchange.DatabaseCrudOnActions(
        model: model, operations: DatabaseCrudDeleteOperations()));
    return model;
  }

  @override
  Future<Result<Model>> update(int id, ModelParams values) async {
    final payload = values.toUpdate();

    payload.addEntries({MapEntry("created_At", DateTime.now())});
    final dataset = payload.keys.map((column) {
      return "$column ='${payload[column]}'";
    }).join(",");
    final effectedrow = await database
        .rawInsert('''update "$tableName" set $dataset where id = $id 
        ''');
    // final result = await database.insert(tableName, map);
    if (effectedrow < 1) {
      return Result(
          exception: ResultException("failed to update", StackTrace.current));
    }
    print("result $effectedrow");
    final model = await _get(id);
    _streamController.sink.add(DatabaseCrudOnchange.DatabaseCrudOnActions(
        model: model, operations: DatabaseCrudUpdateOperations()));
    return model;
  }

  @override
  // TODO: implement database
  Database get database => store.database!;

  @override
  Future<Result<Model>> _get(int id) async {
    final result = await database
        .rawQuery(""" select * from "$tableName" where id=$id limit 1;""");
    if (result.isEmpty) {
      return Result(
          exception: ResultException("not found", StackTrace.current));
    }
    print("get $result");

    return Result(result: parser(result.first));
  }

  bool useRef = false;
  String get query {
    print("useRef $useRef");
    return useRef ? refQuery : nonRefQuery;
  }

  String get nonRefQuery {
    return """select * from $tableName """;
  }

  String get refQuery {
    return """select * from $tableName""";
  }

  Future<Result<List<Model>>> findModel({
    int limit = 20,
    int offset = 0,
    String? where,
    bool useRef = false,
  }) {
    this.useRef = useRef;
    return _completer(_find(limit, offset, where), useRef);
  }

  Future<Result<Model>> getOne(int id, [bool useRef = false]) {
    this.useRef = useRef;
    return _completer(_get(id), useRef);
  }

  Future<Result> _completer<Result>(Future<Result> callback, bool useRef) {
    this.useRef = useRef;
    return callback.whenComplete(() => this.useRef = false);
  }

  @override
  Future<Result<List<Model>>> _find(
      [int limit = 1, int offset = 0, String? where]) async {
    print("query $query");
    final result = await database
        .rawQuery("""$query ${where ?? ""}limit $offset,$limit  """);
    if (result.isEmpty) {
      return Result(
          exception: ResultException("Not Found", StackTrace.current));
    }
    return Result(result: result.map(parser).toList());
  }

  @override
  // TODO: implement onChange
  Stream<DatabaseCrudOnchange> get onActions => _streamController.stream;
}
