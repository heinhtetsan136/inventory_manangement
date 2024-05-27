import 'package:inventory_management_app/core/db/interface/crud_model.dart';

abstract class FormGroup<T extends DatabaseParamModel> {
  FormGroup();

  Result<T> toParams();
}
