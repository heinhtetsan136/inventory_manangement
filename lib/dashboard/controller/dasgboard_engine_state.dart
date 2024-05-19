abstract class DashboardEngineState {
  const DashboardEngineState();
}

class DashboardEngineInitialState extends DashboardEngineState {
  const DashboardEngineInitialState();
}

class DashboardEngineLoadingState extends DashboardEngineState {
  const DashboardEngineLoadingState();
}

class DashboardEngineRadyState extends DashboardEngineState {
  const DashboardEngineRadyState();
}

class DashboardEngineErrorState extends DashboardEngineState {
  final String message;
  const DashboardEngineErrorState(this.message);
}
