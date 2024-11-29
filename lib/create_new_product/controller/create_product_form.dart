import 'package:flutter/material.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/form/field.dart';
import 'package:inventory_management_app/core/form/form.dart';
import 'package:inventory_management_app/repo/product_repo/product_entity.dart';

class CreateProductForm extends FormGroup<ProductParams> {
  final Field<TextEditingController> description,
      name,
      barcode,
      sku,
      price,
      avaiable,
      onHand,
      lost,
      damage;
  final Field<String> coverPhoto;
  final Field<int> categoryId;
  final Field<bool> availableToSellWhenOutOfStock;
  factory CreateProductForm.form() {
    return CreateProductForm(
        availableToSellWhenOutOfStock: Field<bool>(isRequired: false),
        sku: Field.textEditingController(),
        avaiable: Field.textEditingController(),
        onHand: Field.textEditingController(),
        lost: Field.textEditingController(),
        damage: Field.textEditingController(),
        price: Field.textEditingController(),
        coverPhoto: Field<String>(isValid: (p) {
          return p != null ? null : "Category Id is Required";
        }),
        name: Field.textEditingController(),
        description: Field.textEditingController(),
        barcode: Field.textEditingController(),
        categoryId: Field<int>(isValid: (p) {
          return p != null && p > 0 ? null : "Category Id is Required";
        }));
  }

  CreateProductForm(
      {required this.description,
      required this.name,
      required this.barcode,
      required this.sku,
      required this.price,
      required this.avaiable,
      required this.onHand,
      required this.lost,
      required this.damage,
      required this.coverPhoto,
      required this.categoryId,
      required this.availableToSellWhenOutOfStock});
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
