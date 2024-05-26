import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/utils/dialog.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_bloc.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_event.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_state.dart';
import 'package:inventory_management_app/create_new_category/widget/bloc_outlinded_button.dart';
import 'package:inventory_management_app/create_new_category/widget/form_box.dart';
import 'package:starlight_utils/starlight_utils.dart';

class CreateNewCategoryScreen extends StatelessWidget {
  const CreateNewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewCategoryBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Categories",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          CustomOutLinededButton<CreateNewCategoryState,
              CreateNewCategoryBloc>.bloc(
            listenWhen: (p, c) {
              return c is CreateNewCategoryCreatedState ||
                  c is CreateNewCategoryErrorState;
            },
            listener: (_, bloc, state) async {
              if (state is CreateNewCategoryCreatedState) {
                StarlightUtils.pop();
                StarlightUtils.snackbar(SnackBar(
                    content: Text(
                        "${bloc.nameController.text} was sucessfully created")));
                return;
              }
              state as CreateNewCategoryErrorState;
              await dialog("Failed to Create Category", state.message);
            },
            onPressed: (bloc) {
              bloc.add(const CreateNewCategoryEvent());
            },
            label: "Save",
            icon: Icons.save,
          )
        ],
      ),
      body: Form(
        key: bloc.formkey,
        child: FormBox(
          margin: const EdgeInsets.only(top: 20),
          width: context.width,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Category Name",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // expands: true,
                // maxLines: null,
                validator: (v) {
                  print("validator $v");
                  return v?.isNotEmpty == true ? null : "";
                },
                controller: bloc.nameController,
                decoration: const InputDecoration(
                  hintText: "Computer etc...",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
