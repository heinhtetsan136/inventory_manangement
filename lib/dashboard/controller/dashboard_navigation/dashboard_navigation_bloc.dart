import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_navigation/dashboard_navigation_event.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_navigation/dashboard_navigation_state.dart';

class DashBoardNavigationBloc
    extends Bloc<DashBoardNavigationEvent, DashboardNavigationSate> {
  DashBoardNavigationBloc(super.initialState) {
    on<DashBoardNavigationEvent>((event, emit) {
      emit(DashboardNavigationSate(event.i));
    });
  }
}
