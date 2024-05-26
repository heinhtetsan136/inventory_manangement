import 'package:inventory_management_app/core/bloc/basic_state.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';

abstract class SqliteState<Model extends DatabaseModel> extends BasicState {
  final List<Model> list;
  SqliteState(this.list);
}

class SqliteInitialState<Model extends DatabaseModel>
    extends SqliteState<Model> {
  SqliteInitialState(List<Model> Model) : super(Model);
}

class SqliteReceiveState<Model extends DatabaseModel>
    extends SqliteState<Model> {
  SqliteReceiveState(super.list);
}

class SqliteErrorState<Model extends DatabaseModel> extends SqliteState<Model> {
  final String message;
  SqliteErrorState(super.list, this.message);
}

class SqliteLoadingState<Model extends DatabaseModel>
    extends SqliteState<Model> {
  SqliteLoadingState(super.list);
}

class SqliteSoftLoadingState<Model extends DatabaseModel>
    extends SqliteState<Model> {
  SqliteSoftLoadingState(super.list);
}
