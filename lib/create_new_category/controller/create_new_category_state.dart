import 'package:inventory_management_app/core/bloc/basic_state.dart';

abstract class CreateNewCategoryState extends BasicState {
  CreateNewCategoryState();
}

class CreateNewCategoryInitialState extends CreateNewCategoryState {
  CreateNewCategoryInitialState();
}

class CreateNewCategoryCreatingState extends CreateNewCategoryState {
  CreateNewCategoryCreatingState();
}

class CreateNewCategoryErrorState extends CreateNewCategoryState {
  final String message;
  CreateNewCategoryErrorState(this.message);
}

class CreateNewCategoryCreatedState extends CreateNewCategoryState {
  CreateNewCategoryCreatedState();
}
