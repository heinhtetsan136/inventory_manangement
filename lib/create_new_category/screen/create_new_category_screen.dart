import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_create_event.dart';
import 'package:inventory_management_app/core/bloc/sql_create_state.dart';
import 'package:inventory_management_app/core/utils/dialog.dart';
import 'package:inventory_management_app/create_new_category/controller/create_new_category_form_bloc.dart';
import 'package:inventory_management_app/create_new_category/widget/bloc_outlinded_button.dart';
import 'package:inventory_management_app/create_new_category/widget/form_box.dart';
import 'package:starlight_utils/starlight_utils.dart';

class CreateNewCategoryScreen extends StatelessWidget {
  const CreateNewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewCategoryFormBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Categories",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          CustomOutLinededButton<SqlCreateState,
              CreateNewCategoryFormBloc>.bloc(
            // listenWhen: (p, c) {
            //   return c is SqlCreateErrorState || c is SqlCreatedState;
            // },
            listener: (_, bloc, state) async {
              print("uistate is $state");
              if (state is SqlCreatedState) {
                StarlightUtils.pop();
                StarlightUtils.snackbar(SnackBar(
                    content: Text(
                        "${bloc.form.name.input!.text} was sucessfully created")));
                return;
              }
              state as SqlCreateErrorState;
              await dialog("Failed to Create Category", state.message);
            },
            onPressed: (bloc) {
              bloc.add(const SqlCreateEvent());
            },
            label: "Save",
            icon: Icons.save,
          )
        ],
      ),
      body: Form(
        key: bloc.form.formkey,
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
                controller:
                    context.read<CreateNewCategoryFormBloc>().form.name.input,
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
