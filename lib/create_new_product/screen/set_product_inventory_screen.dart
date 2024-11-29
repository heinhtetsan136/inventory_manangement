import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/create_new_product/controller/create_new_product_bloc.dart';
import 'package:inventory_management_app/widget/box/form_box.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';
import 'package:starlight_utils/starlight_utils.dart';

class SetProductInventoryScreen extends StatelessWidget {
  const SetProductInventoryScreen({super.key});
  void submmit(CreateNewProductBloc bloc) {
    if (!_doubleCheck(bloc.form.avaiable.input!.text)) {
      print(bloc.form.avaiable.input!.text);
      _showSnackBar("Avaiable must be Number");
      return;
    }
    if (!_doubleCheck(bloc.form.onHand.input!.text)) {
      _showSnackBar("ON Hand must be Number");
      return;
    }
    if (!_doubleCheck(bloc.form.lost.input!.text)) {
      _showSnackBar("lost must be Number");
      return;
    }
    if (!_doubleCheck(bloc.form.damage.input!.text)) {
      _showSnackBar("Demage must be Number");
      return;
    }
    StarlightUtils.pop();
  }

  bool _doubleCheck(String text) {
    return text.isEmpty ? true : double.tryParse(text) != null;
  }

  void _showSnackBar(String text) {
    StarlightUtils.snackbar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final createNewProductBloc = context.read<CreateNewProductBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Product Inventory"),
        actions: [
          CustomOutLinededButton(
            onPressed: () {
              print("add inventory");
              submmit(createNewProductBloc);
            },
            label: "Add Inventory",
            icon: Icons.save_outlined,
          )
        ],
      ),
      body: ListView(
        children: [
          FormBox(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: createNewProductBloc.form.sku.input,
                    decoration: const InputDecoration(hintText: "Sku"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: createNewProductBloc.form.barcode.input,
                      decoration: InputDecoration(
                          hintText: "Barcode",
                          suffixIcon: InkWell(
                              onTap: () {}, child: const Icon(Icons.qr_code))),
                    ),
                  ),
                ],
              )),
          FormBox(
              child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  return value == null
                      ? null
                      : double.tryParse(value) == null
                          ? ""
                          : null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: createNewProductBloc.form.avaiable.input,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "available"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  validator: (value) {
                    return value == null
                        ? null
                        : double.tryParse(value) == null
                            ? ""
                            : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: createNewProductBloc.form.onHand.input,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "on_hand"),
                ),
              ),
              TextFormField(
                validator: (value) {
                  return value == null
                      ? null
                      : double.tryParse(value) == null
                          ? ""
                          : null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: createNewProductBloc.form.lost.input,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "lost"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  validator: (value) {
                    return value == null
                        ? null
                        : double.tryParse(value) == null
                            ? ""
                            : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: createNewProductBloc.form.damage.input,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "damage"),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
