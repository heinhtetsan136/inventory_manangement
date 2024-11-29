import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/create_new_product/controller/create_new_product_bloc.dart';
import 'package:inventory_management_app/widget/box/form_box.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';
import 'package:starlight_utils/starlight_utils.dart';

class SetProductPriceScreen extends StatelessWidget {
  const SetProductPriceScreen({super.key});
  void submit(String text) {
    final value = double.tryParse(text) ?? -1;
    if (value < 0) {
      StarlightUtils.snackbar(
          const SnackBar(content: Text("Please set a valid price")));
      return;
    }
    StarlightUtils.pop(result: value);
  }

  @override
  Widget build(BuildContext context) {
    final createnewproductbloc = context.read<CreateNewProductBloc>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomOutLinededButton(
            onPressed: () {
              submit(createnewproductbloc.form.price.input!.text);
            },
            label: "Saved",
            icon: Icons.save_outlined,
          )
        ],
        title: const Text("Set Price"),
      ),
      body: FormBox(
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: createnewproductbloc.form.price.input,
            onEditingComplete: () {
              submit(createnewproductbloc.form.price.input!.text);
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "example: 1000"),
            validator: (value) {
              final parse = double.tryParse(value ?? "");
              return parse == null
                  ? ""
                  : parse < 0
                      ? ""
                      : null;
            },
          )),
    );
  }
}
