

// class CreateNewShopBloc extends Bloc<CreateNewShopEvent, CreateNewShopState> {
//   CreateNewShopBloc(super.initialState);
//   // final TextEditingController controller;

//   // final SqlShopRepo shopRepo;
//   // final ImagePicker imagePicker;
//   // CreateNewShopBloc(super.initialState, this.imagePicker, this.shopRepo)
//   //     : controller = TextEditingController() {
//   //   on<CreateNewShopPickCoverPhotoEvent>(_createNewShopPickCoverPhotoEvent);
//   //   on<CreateNewShopCreateShopEvent>(_createNewShopCreateShopEvent);
//   // }

//   // FutureOr<void> _createNewShopCreateShopEvent(event, emit) async {
//   //   logger.i(event);
//   //   assert(formkey?.currentState?.validate() == true);
//   //   if (state.coverPhotoPath == null) {
//   //     return emit(CreateNewShopErrorState(
//   //         coverPhotoPath: null, message: "Cover Photo is Missing"));
//   //   }
//   //   if (state is CreateNewShopCreatingState) {
//   //     return;
//   //   }
//   //   emit(CreateNewShopCreatingState(coverPhotoPath: state.coverPhotoPath));
//   //   final result = await shopRepo.create(ShopParams.toCreate(
//   //       name: controller.text, cover_photo: state.coverPhotoPath!));
//   //   if (result.hasError) {
//   //     emit(CreateNewShopErrorState(
//   //         coverPhotoPath: state.coverPhotoPath,
//   //         message: result.exception!.message));
//   //     return;
//   //   }
//   //   emit(CreateNewShopCreatedState());
//   // }

//   // FutureOr<void> _createNewShopPickCoverPhotoEvent(_, emit) async {
//   //   final XFile? file =
//   //       await imagePicker.pickImage(source: ImageSource.gallery);
//   //   if (file == null) return;
//   //   emit(CreateNewShopCoverPhotoSelectedState(coverPhotoPath: file.path));
//   // }

//   // final GlobalKey<FormState>? formkey = GlobalKey<FormState>();
//   // @override
//   // Future<void> close() {
//   //   formkey == null;
//   //   controller.dispose();
//   //   // TODO: implement close
//   //   return super.close();
//   // }
// }
