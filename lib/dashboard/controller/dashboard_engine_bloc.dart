import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/container.dart';
import 'package:inventory_management_app/dashboard/controller/dasgboard_engine_state.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_engine_event.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:inventory_management_app/repo/dashboard/dashboard_repo.dart';

class DashBoardEngineBloc
    extends Bloc<DashBoardEngineEvent, DashboardEngineState> {
  final DashBoardEngineRepo repo;
  StreamSubscription? _subscription;
  DashBoardEngineBloc(super.initialState, this.repo) {
    _subscription = repo.isReady.listen((event) {
      add(DashBoardEngineStreamEvent(event));
    });
    on<DashBoardEngineStreamEvent>((event, emit) {
      print("container ${event.result.toString()}");
      if (event.result.hasError) {
        print("container ${event.result.exception!.message.toString()}");
        emit(DashboardEngineErrorState(event.result.toString()));
        return;
      }
      emit(const DashboardEngineRadyState());
    });
    on<DashBoardEngineInitEvent>((event, emit) async {
      emit(const DashboardEngineLoadingState());
      await repo.init();
    });
    add(const DashBoardEngineInitEvent());
  }

  @override
  Future<void> close() async {
    print("container close");
    logger.e(
        "container ${container.exists<DashBoardEngineBloc>()} ${container.exists<DashBoardEngineRepo>()} ");
    // container.remove<DashBoardEngineBloc>();
    // container.remove<DashBoardEngineRepo>();
    await Future.wait(
        [repo.dispose(), _subscription?.cancel() ?? Future.value()]);
    // TODO: implement close
    return super
        .close()
        .then((value) => container.remove<DashBoardEngineBloc>());
  }
}
