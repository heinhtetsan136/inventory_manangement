import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/category/controller/category_list_bloc.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';
import 'package:starlight_utils/starlight_utils.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Product"),
        actions: [
          CustomOutLinededButton(
            onPressed: () {
              StarlightUtils.pushNamed(RouteNames.createNewProduct,
                  arguments: context.read<CategoryListBloc>());
            },
            label: "Create Product",
            icon: Icons.add,
          )
        ],
      ),
    );
  }
}
