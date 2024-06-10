import 'package:flutter/material.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/form/field.dart';
import 'package:inventory_management_app/core/form/form.dart';
import 'package:inventory_management_app/repo/product_repo/product_entity.dart';

class CreateProductForm extends FormGroup<ProductParams> {
  CreateProductForm(
      {required this.name,
      required this.description,
      required this.barcode,
      required this.categoryId});
  final Field<TextEditingController> name;
  final Field<TextEditingController> description;
  final Field<TextEditingController> barcode;
  final Field<int> categoryId;
  factory CreateProductForm.form() {
    return CreateProductForm(
        name: Field.textEditingController(),
        description: Field.textEditingController(),
        barcode: Field.textEditingController(),
        categoryId: Field(isValid: (p) {
          return p != null && p > 0 ? null : "Category Id is Required";
        }));
  }
  @override
  void dispose() {
    formkey == null;
    formDispose(form);
  }

  @override
  // TODO: implement form
  List<Field> get form => [name, barcode, description, categoryId];

  @override
  // TODO: implement formkey
  GlobalKey<FormState>? formkey = GlobalKey<FormState>();

  @override
  Result<ProductParams> toParams() {
    final errorMessage = formisValid(form);
    if (errorMessage != null) {
      return Result(exception: ResultException(errorMessage.toString()));
    }
    return Result(
        result: ProductParams.created(
      name: name.input!.text,
      category_id: categoryId.input!,
      barcode: name.input!.text,
    ));
  }

  @override
  bool validate() {
    // return formkey?.currentState?.validate() == true;
    return true;
  }
}
