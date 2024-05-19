import 'package:inventory_management_app/core/db/interface/crud_model.dart';

abstract class DashBoardEngineEvent {
  const DashBoardEngineEvent();
}

class DashBoardEngineInitEvent extends DashBoardEngineEvent {
  const DashBoardEngineInitEvent();
}

class DashBoardEngineStreamEvent extends DashBoardEngineEvent {
  final Result result;
  DashBoardEngineStreamEvent(this.result);
}
