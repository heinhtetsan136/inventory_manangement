import 'package:inventory_management_app/core/db/interface/crud_model.dart';

abstract class SqliteEvent<Model extends DatabaseModel> {
  const SqliteEvent();
}

class SqliteGetEvent<Model extends DatabaseModel> extends SqliteEvent<Model> {
  SqliteGetEvent();
}

class SqliteCreatedEvent<Model extends DatabaseModel>
    extends SqliteEvent<Model> {
  final Result<Model> model;
  SqliteCreatedEvent(this.model);
}

class SqliteUpdatedEvent<Model extends DatabaseModel>
    extends SqliteEvent<Model> {
  final Result<Model> model;
  SqliteUpdatedEvent(this.model);
}

class SqliteDeletedEvent<Model extends DatabaseModel>
    extends SqliteEvent<Model> {
  final Result<Model> model;
  SqliteDeletedEvent(this.model);
}
