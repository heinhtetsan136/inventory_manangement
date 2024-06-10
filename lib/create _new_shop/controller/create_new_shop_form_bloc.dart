import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_app/core/bloc/sql_create_bloc.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_event.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_form.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_state.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';
import 'package:inventory_management_app/repo/shop_repo/sqlshop_repo.dart';

class CreateNewShopFormBloc
    extends SqlCreateBloc<Shop, ShopParams, SqlShopRepo, ShopCreateForm> {
  final ImagePicker imagePicker;
  CreateNewShopFormBloc(super.repo, super.form, this.imagePicker) {
    on<CreateNewShopPickCoverPhotoEvent>(
        _createnewshoppickedcoverphotoEventListener);
    //   on<CreateNewShopCreateShopEvent>(_createnewshopcreateshopeventListener);
    // }

    // FutureOr<void> _createnewshopcreateshopeventListener(_, emit) async {
    //   if (!form.validate()) return;
    //   if (state is CreateNewShopCreatingState) return;
    //   emit(CreateNewShopCreatingState());
    //   final params = form.toParams();
    //   if (params.hasError) {
    //     emit(CreateNewShopErrorState(message: params.toString()));
    //   }
    //   final result = await shop.create(params.result!);
    //   if (result.hasError) {
    //     emit(CreateNewShopErrorState(message: result.exception!.message));
    //   }
    //   emit(CreateNewShopCreatedState());
    // }
  }
  FutureOr<void> _createnewshoppickedcoverphotoEventListener(
      event, emit) async {
    final picked = await imagePicker.pickImage(source: ImageSource.gallery);
    if (picked == null) {
      return;
    }
    form.coverphotopath.input = picked.path;
    emit(CreateNewShopCoverPhotoSelectedState());
  }
}
