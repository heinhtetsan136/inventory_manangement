import 'package:inventory_management_app/core/bloc/sql_create_bloc.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_form.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';
import 'package:inventory_management_app/repo/category_repo/category_repo.dart';

class CreateNewCategoryFormBloc extends SqlCreateBloc<Category, CategoryParams,
    SqliteCategoryRepo, CreateNewCategoryForm> {
  CreateNewCategoryFormBloc(super.initialState, super.repo, super.form) {
    print("categorystate is $state");
  }
  @override
  Future<void> close() {
    print("category close");
    // TODO: implement close
    return super.close();
  }
}
