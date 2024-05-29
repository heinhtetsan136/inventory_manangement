import 'package:flutter/cupertino.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/form/field.dart';
import 'package:inventory_management_app/core/form/form.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';

class CreateNewCategoryForm extends FormGroup<CategoryParams> {
  final Field<TextEditingController> name;

  CreateNewCategoryForm({required this.name});
  @override
  void dispose() {
    formkey == null;
    formDispose(form);
  }

  factory CreateNewCategoryForm.form() {
    return CreateNewCategoryForm(
      name: Field(
          isRequired: false,
          input: TextEditingController(),
          dispose: ((p0) => p0?.dispose())),
    );
  }

  @override
  // TODO: implement form
  List<Field> get form => [name];

  @override
  // TODO: implement formkey
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Result<CategoryParams> toParams() {
    final errormessage = formisValid(form);
    print(errormessage);
    if (errormessage != null) {
      return Result(exception: ResultException(errormessage.toString()));
    }
    return Result(result: CategoryParams.create(name: name.input!.text));
  }

  @override
  bool validate() {
    return formkey.currentState?.validate() == true;
  }
}
