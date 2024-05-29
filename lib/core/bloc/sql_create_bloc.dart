import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_create_event.dart';
import 'package:inventory_management_app/core/bloc/sql_create_state.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/form/form.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';

abstract class SqlCreateBloc<
        Model extends DatabaseModel,
        Param extends DatabaseParamModel,
        Repo extends sqliteRepo<Model, Param>,
        Forms extends FormGroup<Param>>
    extends Bloc<SqlCreateBaseEvent, SqlCreateState> {
  final Repo repo;
  final Forms form;
  SqlCreateBloc(super.initialState, this.repo, this.form) {
    on<SqlCreateEvent>(_sqlCreateEventListner);
  }

  FutureOr<void> _sqlCreateEventListner(_, emit) async {
    print("state is $state");
    if (state is SqlCreatingState) {
      return;
    }
    print("state is $state");
    if (!form.validate()) return;
    final values = form.toParams();
    if (values.hasError) {
      emit(SqlCreateErrorState(values.exception!.message));
      return;
    }
    emit(SqlCreatingState());
    final result = await repo.create(values.result!);
    if (result.hasError) {
      emit(SqlCreateErrorState(result.exception!.message));
      return;
    }
    emit(SqlCreatedState());
  }

  @override
  Future<void> close() {
    print("state is close");
    form.dispose();
    // TODO: implement close
    return super.close();
  }
}
