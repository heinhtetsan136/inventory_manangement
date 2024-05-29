import 'package:inventory_management_app/core/bloc/basic_state.dart';

abstract class SqlCreateState extends BasicState {
  SqlCreateState();
}

class SqlCreatingState extends SqlCreateState {
  SqlCreatingState();
}

class SqliteCreateInitialState extends SqlCreateState {}

class SqlCreateErrorState extends SqlCreateState {
  final String message;
  SqlCreateErrorState(this.message);
}

class SqlCreatedState extends SqlCreateState {
  SqlCreatedState();
}
