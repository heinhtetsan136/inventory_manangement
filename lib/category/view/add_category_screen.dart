import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/category/controller/category_list_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_read_state.dart';
import 'package:inventory_management_app/repo/category_repo/category_entity.dart';
import 'package:inventory_management_app/widget/box/form_box.dart';
import 'package:starlight_utils/starlight_utils.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: Column(
        children: [
          const FormBox(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 10, bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                ),
              )),
          Expanded(child: BlocBuilder<CategoryListBloc, SqliteState<Category>>(
              builder: (_, state) {
            return ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                separatorBuilder: (_, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: state.list.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    onTap: () {
                      StarlightUtils.pop(result: state.list[index]);
                    },
                    title: Text(state.list[index].name),
                  );
                });
          }))
        ],
      ),
    );
  }
}
