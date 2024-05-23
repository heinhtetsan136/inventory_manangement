import 'package:flutter/material.dart';
import 'package:inventory_management_app/create_new_category/widget/bloc_outlinded_button.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:starlight_utils/starlight_utils.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CustomOutLinededButton(
                onPressed: () {
                  StarlightUtils.pushNamed(RouteNames.createNewCategory);
                },
                label: "Create Category",
                icon: Icons.add,
              ))
        ],
      ),
    );
  }
}
