import 'dart:async';

import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';

abstract class DatabaseCrudOperations {}

class DatabaseCrudCreateOperations extends DatabaseCrudOperations {}

class DatabaseCrudUpdateOperations extends DatabaseCrudOperations {}

class DatabaseCrudDeleteOperations extends DatabaseCrudOperations {}

class DatabaseCrudOnchange<Model extends DatabaseModel> {
  final Result<Model> model;
  final DatabaseCrudOperations operations;

  DatabaseCrudOnchange.DatabaseCrudOnActions(
      {required this.model, required this.operations});
}

abstract class DatabaseCrud<DatabaseType, Model extends DatabaseModel,
    ModelParams extends DatabaseParamModel> {
  final DataStore<DatabaseType> store;
  Stream<DatabaseCrudOnchange> get onActions;
  DatabaseType get database => store.database!;
  final String tableName;
  DatabaseCrud({required this.tableName, required this.store});
  Future<Result<List<Model>>> _find(
      [int limit = 20, int offset = 0, String? where]);
  Future<Result<Model>> _get(int id);
  Future<Result<Model>> create(ModelParams value);
  Future<Result<Model>> update(int id, ModelParams value);
  Future<Result<Model>> delete(int id);
}
