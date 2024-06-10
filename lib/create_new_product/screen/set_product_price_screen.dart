import 'package:flutter/material.dart';
import 'package:inventory_management_app/widget/box/form_box.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';
import 'package:starlight_utils/starlight_utils.dart';

class SetProductPriceScreen extends StatelessWidget {
  const SetProductPriceScreen({super.key});
  void submit(double value) {
    if (value < 0) {
      StarlightUtils.snackbar(
          const SnackBar(content: Text("Please set a valid price")));
      return;
    }
    StarlightUtils.pop(result: value);
  }

  @override
  Widget build(BuildContext context) {
    double value = -1;
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomOutLinededButton(
            onPressed: () {
              submit(value);
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
            onEditingComplete: () {
              submit(value);
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (char) {
              value = double.tryParse(char) ?? -1;
            },
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
