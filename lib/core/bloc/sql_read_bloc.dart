import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_read_event.dart';
import 'package:inventory_management_app/core/bloc/sql_read_state.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/db/interface/database_crud.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';
import 'package:inventory_management_app/logger/logger.dart';

abstract class SqliteReadBloc<
        Model extends DatabaseModel,
        ModelParams extends DatabaseParamModel,
        Repo extends sqliteRepo<Model, ModelParams>>
    extends Bloc<SqliteEvent<Model>, SqliteState<Model>> {
  StreamSubscription? _onchangeSubscription;
  int currentoffset = 0;
  final Repo repo;
  SqliteReadBloc(
    super.initialState,
    this.repo,
  ) {
    _onchangeSubscription = repo.onActions.listen(_SqliteOnActionListener);
    on<SqliteCreatedEvent<Model>>(_SqliteCreatedEventListener);
    on<SqliteUpdatedEvent<Model>>(_SqliteUpdateEventListener);
    on<SqliteDeletedEvent<Model>>(_SqliteDeletedEventListener);
    on<SqliteGetEvent<Model>>(_Sqlitegeteventlistener);
    add(SqliteGetEvent());
  }

  void _SqliteOnActionListener(event) {
    final Result<Model> repo = event.model;
    if (event.operations is DatabaseCrudCreateOperations) {
      add(SqliteCreatedEvent(event.model));
      return;
    }
    if (event.operations is DatabaseCrudUpdateOperations) {
      add(SqliteUpdatedEvent(event.model.result));
      return;
    }
    add(SqliteDeletedEvent(event.model.result));
  }

  FutureOr<void> _SqliteDeletedEventListener(event, emit) {
    final list = state.list.toList();
    list.remove(event.model.result);
    emit(SqliteReceiveState(list));
  }

  FutureOr<void> _SqliteUpdateEventListener(event, emit) {
    final list = state.list.toList();
    final index = list.indexOf(event.model.result);
    list[index] = event.model.result;
    emit(SqliteReceiveState(list));
  }

  FutureOr<void> _SqliteCreatedEventListener(event, emit) {
    final list = state.list.toList();
    list.add(event.model.result);
    emit(SqliteReceiveState(list));
  }

  FutureOr<void> _Sqlitegeteventlistener(_, emit) async {
    if (state is SqliteLoadingState || state is SqliteSoftLoadingState) {
      return;
    }
    final list = state.list.toList();
    if (list.isEmpty) {
      emit(SqliteLoadingState(list));
    } else {
      emit(SqliteSoftLoadingState(list));
    }

    final result = await repo.findModel(offset: currentoffset);
    logger.i("repolistgetevent $result ");
    if (result.hasError) {
      emit(SqliteErrorState(list, result.exception!.message));
    }
    final incominglist = result.result?.toList() ?? [];
    if (incominglist.isEmpty) {
      emit(SqliteReceiveState(list));
      return;
    }

    currentoffset += incominglist.length;
    logger.i(incominglist);
    list.addAll(incominglist);

    emit(SqliteReceiveState(state.list.toList()));
  }

  @override
  Future<void> close() async {
    await _onchangeSubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
