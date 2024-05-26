import 'package:inventory_management_app/core/bloc/sql_read_bloc.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';
import 'package:inventory_management_app/repo/category_repo/category_repo.dart';

class CategoryListBloc
    extends SqliteReadBloc<Category, CategoryParams, SqliteCategoryRepo> {
  CategoryListBloc(super.initialState, super.repo);
}
