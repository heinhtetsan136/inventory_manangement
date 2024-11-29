import 'dart:async';

import 'package:inventory_management_app/container.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/impl/sqliteDatabase.dart';
import 'package:inventory_management_app/repo/category_repo/category_repo.dart';
import 'package:inventory_management_app/repo/product_repo/product_repo.dart';
import 'package:inventory_management_app/repo/variant_repo/variant_repo.dart';

class DashBoardEngineRepo {
  final String shopName;
  final SqlliteDatabase _database;
  final StreamController<Result> _isReady;

  DashBoardEngineRepo({
    required this.shopName,
    required SqlliteDatabase database,
  })  : _database = database,
        _isReady = StreamController.broadcast();
  Stream<Result> get isReady => _isReady.stream;
  Future<void> init() async {
    final result = await _database.connect();
    // if (result.hasError) {
    //   _isReady.sink.add(Result(exception: ResultException("Unknown Error")));
    // }
    container.setLazy<SqliteCategoryRepo>(() {
      return SqliteCategoryRepo(_database);
    });
    container.setLazy<SqlProductRepo>(() {
      return SqlProductRepo(_database);
    });
    container.setLazy<SqlVariantRepo>(() {
      return SqlVariantRepo(_database);
    });
    _validate();
    _isReady.sink.add(result);
  }

  void _validate() {
    assert(container.exists<SqliteCategoryRepo>() &&
        container.exists<SqlProductRepo>());
  }

  Future<void> dispose() async {
    _validate();
    container.remove<SqliteCategoryRepo>();
    container.remove<SqlProductRepo>();
    await Future.wait([
      _isReady.close(),
      _database.close(),
    ]).then((value) => container.remove<DashBoardEngineRepo>());
  }
}
