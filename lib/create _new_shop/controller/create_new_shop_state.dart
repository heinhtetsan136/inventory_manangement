abstract class CreateNewShopState {
  final String? coverPhotoPath;
  final DateTime? dateTime;

  CreateNewShopState({required this.coverPhotoPath})
      : dateTime = DateTime.now();
  @override
  bool operator ==(covariant CreateNewShopState other) {
    return other.coverPhotoPath == coverPhotoPath && other.dateTime == dateTime;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => coverPhotoPath.hashCode;
}

class CreateNewShopInitialState extends CreateNewShopState {
  CreateNewShopInitialState() : super(coverPhotoPath: null);
}

class CreateNewShopCoverPhotoSelectedState extends CreateNewShopState {
  CreateNewShopCoverPhotoSelectedState({required super.coverPhotoPath});
}

class CreateNewShopCreatingState extends CreateNewShopState {
  CreateNewShopCreatingState({required super.coverPhotoPath});
}

class CreateNewShopCreatedState extends CreateNewShopState {
  CreateNewShopCreatedState() : super(coverPhotoPath: null);
}

class CreateNewShopErrorState extends CreateNewShopState {
  final String message;
  CreateNewShopErrorState(
      {required super.coverPhotoPath, required this.message});
}
