import 'package:flutter/material.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/form/field.dart';
import 'package:inventory_management_app/core/form/form.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';

class ShopCreateForm implements FormGroup<ShopParams> {
  @override
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Field<TextEditingController> name;
  final Field<String> coverphotopath;

  ShopCreateForm({required this.name, required this.coverphotopath});
  @override
  Result<ShopParams> toParams() {
    final errormessage = formisValid(form);
    print(errormessage);
    if (errormessage == null) {
      return Result(
          result: ShopParams.toCreate(
              name: name.input!.text, cover_photo: coverphotopath.input!));
    }
    return Result(exception: ResultException(errormessage));
  }

  // factory ShopCreateForm.updateForms(
  //   String name,
  //   String coverphoto,
  // ) {
  //   return ShopCreateForm(
  //       name: Field(
  //           isRequired: false,
  //           input: TextEditingController(),
  //           dispose: ((p0) => p0.dispose())),
  //       coverphotopath: Field(isValid: ((p0) {
  //         return p0?.isNotEmpty == true ? null : "Cover Photo is Required ";
  //       })));
  // }
  factory ShopCreateForm.createForms() {
    return ShopCreateForm(
        name: Field(
            isRequired: false,
            input: TextEditingController(),
            dispose: ((p0) => p0?.dispose())),
        coverphotopath: Field(isValid: ((p0) {
          return p0?.isNotEmpty == true ? null : "Cover Photo is Required ";
        })));
  }
  @override
  List<Field> get form => [name, coverphotopath];
  @override
  void dispose() {
    formkey == null;
    formDispose(form);
  }

  @override
  bool validate() {
    return formkey.currentState?.validate() == true;
  }
}
