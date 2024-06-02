import 'package:inventory_management_app/core/db/interface/table.dart';

abstract class SqlBaseMigration {
  Map<String, List<TableProperties>> get table {
    _load();
    return db;
  }

  SqlBaseMigration([Map<String, List<TableProperties>>? migration])
      : db = migration ?? {};
  Map<String, List<TableProperties>> get up;
  Map<String, List<TableProperties>> get down;
  final Map<String, List<TableProperties>> db;
  _load() {
    down.forEach((tableName, columns) {
      final isExist = db[tableName];
      if (isExist == null) {
        return;
      }
      for (final column in columns) {
        db[tableName]!.remove(column);
      }
    });
    up.forEach((tableName, columns) {
      final isExist = db[tableName];
      if (isExist == null) {
        db[tableName] = columns;
        return;
      }
      for (final column in columns) {
        final index = isExist.indexOf(column);
        if (index >= 0) {
          db[tableName]![index] = column;
        } else {
          db[tableName]!.add(column);
        }
      }
    });
  }
}
