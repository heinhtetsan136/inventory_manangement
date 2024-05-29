import 'package:inventory_management_app/core/bloc/sql_create_state.dart';

abstract class CreateNewShopState {
  final DateTime? dateTime;

  CreateNewShopState() : dateTime = DateTime.now();
  @override
  bool operator ==(covariant CreateNewShopState other) {
    return other.dateTime == dateTime;
  }
}

class CreateNewShopInitialState extends CreateNewShopState {
  CreateNewShopInitialState() : super();
}

class CreateNewShopCoverPhotoSelectedState extends SqlCreateState {
  CreateNewShopCoverPhotoSelectedState();
}

class CreateNewShopCreatingState extends CreateNewShopState {
  CreateNewShopCreatingState();
}

class CreateNewShopCreatedState extends CreateNewShopState {
  CreateNewShopCreatedState();
}

class CreateNewShopErrorState extends CreateNewShopState {
  final String message;
  CreateNewShopErrorState({required this.message});
}
