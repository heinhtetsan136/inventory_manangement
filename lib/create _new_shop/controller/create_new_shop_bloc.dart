import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_event.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_state.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_repo.dart';

class CreateNewShopBloc extends Bloc<CreateNewShopEvent, CreateNewShopState> {
  final TextEditingController controller;
  final SqlShopRepo shopRepo;
  final ImagePicker imagePicker;
  CreateNewShopBloc(super.initialState, this.imagePicker, this.shopRepo)
      : controller = TextEditingController() {
    on<CreateNewShopPickCoverPhotoEvent>(_createNewShopPickCoverPhotoEvent);
    on<CreateNewShopCreateShopEvent>(_createNewShopCreateShopEvent);
  }

  FutureOr<void> _createNewShopCreateShopEvent(event, emit) async {
    if (state.coverPhotoPath != null || state is! CreateNewShopCreatingState) {
      return;
    }
    emit(CreateNewShopCreatingState(coverPhotoPath: state.coverPhotoPath));
    final result = await shopRepo.create(ShopParams.toCreate(
        name: controller.text, cover_photo: state.coverPhotoPath!));
    if (result.hasError) {
      emit(CreateNewShopErrorState(coverPhotoPath: state.coverPhotoPath));
      return;
    }
    emit(CreateNewShopCreatedState());
  }

  FutureOr<void> _createNewShopPickCoverPhotoEvent(_, emit) async {
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    emit(CreateNewShopCoverPhotoSelectedState(coverPhotoPath: file.path));
  }

  @override
  Future<void> close() {
    controller.dispose();
    // TODO: implement close
    return super.close();
  }
}
