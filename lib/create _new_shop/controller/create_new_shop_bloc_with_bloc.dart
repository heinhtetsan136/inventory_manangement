import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/form/field.dart';
import 'package:inventory_management_app/core/form/form.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_event.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_state.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';
import 'package:inventory_management_app/repo/shop_repo/sqlshop_repo.dart';

class ShopForm implements FormGroup<ShopParams> {
  final Field<TextEditingController> name;
  final Field<String> coverphotopath;

  ShopForm({required this.name, required this.coverphotopath});
  @override
  Result<ShopParams> toParams() {
    final errormessage = isValid([name, coverphotopath]);
    if (errormessage == null) {
      return Result(
          result: ShopParams.toCreate(
              name: name.data!.text, cover_photo: coverphotopath.data!));
    }
    return Result(exception: ResultException(errormessage));
  }
}

class CreateNewShopFormBloc
    extends Bloc<CreateNewShopEvent, CreateNewShopState> {
  final FormGroup<ShopParams> form;
  final SqlShopRepo shop;
  final ImagePicker imagePicker;
  CreateNewShopFormBloc(
      super.initialState, this.form, this.shop, this.imagePicker) {
    on<CreateNewShopCreateShopEvent>((_, emit) async {
      if (state is CreateNewShopCreatingState) return;
      emit(CreateNewShopCreatingState(coverPhotoPath: ""));
      final params = form.toParams();
      if (params.hasError) {
        emit(CreateNewShopErrorState(
            coverPhotoPath: null, message: params.toString()));
      }
      final result = await shop.create(params.result!);
      if (result.hasError) {
        emit(CreateNewShopErrorState(
            coverPhotoPath: null, message: result.exception!.message));
      }
      emit(CreateNewShopCreatedState());
    });
  }
}
