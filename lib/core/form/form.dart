import 'package:flutter/cupertino.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/form/field.dart';

abstract class FormGroup<T extends DatabaseParamModel> {
  GlobalKey<FormState>? get formkey;
  FormGroup();
  bool validate();
  List<Field> get form;
  Result<T> toParams();
  void dispose();
}
