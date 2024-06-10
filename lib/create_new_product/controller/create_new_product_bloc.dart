import 'package:inventory_management_app/core/bloc/sql_create_bloc.dart';
import 'package:inventory_management_app/create_new_product/controller/create_product_form.dart';
import 'package:inventory_management_app/repo/product_repo/product_entity.dart';
import 'package:inventory_management_app/repo/product_repo/product_repo.dart';

class CreateNewProductBloc extends SqlCreateBloc<Product, ProductParams,
    SqlProductRepo, CreateProductForm> {
  CreateNewProductBloc(super.repo, super.form);
}
