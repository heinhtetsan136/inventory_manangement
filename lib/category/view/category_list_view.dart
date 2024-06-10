import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/category/controller/category_list_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_read_state.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';
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
                  // StarlightUtils.pushNamed(RouteNames.createNewCategory);
                  StarlightUtils.pushNamed(RouteNames.createNewCategory);
                },
                label: "Create Category",
                icon: Icons.add,
              ))
        ],
      ),
      body: BlocBuilder<CategoryListBloc, SqliteState<Category>>(
          builder: (_, state) {
        return ListView.builder(
          itemBuilder: (_, i) {
            return ListTile(
              title: Text(state.list[i].name),
            );
          },
          itemCount: state.list.length,
        );
      }),
    );
  }
}
