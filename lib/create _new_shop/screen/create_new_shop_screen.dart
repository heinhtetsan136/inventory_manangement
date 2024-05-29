import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_create_event.dart';
import 'package:inventory_management_app/core/bloc/sql_create_state.dart';
import 'package:inventory_management_app/core/utils/dialog.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_event.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_form_bloc.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:starlight_utils/starlight_utils.dart';

class CreateNewShopScreen extends StatelessWidget {
  const CreateNewShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createNewShopFormBloc = context.read<CreateNewShopFormBloc>();
    final middleWidth = context.width * 0.14;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: createNewShopFormBloc.form.formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          StarlightUtils.pop();
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Padding(
                      padding: EdgeInsets.only(left: middleWidth),
                      child: const Text(
                        "Create New Shop",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 10),
                child: ShopCoverPhotoPicker(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  validator: (v) {
                    return v?.isNotEmpty == true
                        ? v!.contains("_") == true
                            ? "_ is not accept"
                            : null
                        : "shop name is required";
                  },
                  controller: createNewShopFormBloc.form.name.input,
                  decoration: const InputDecoration(hintText: "Shop Name"),
                ),
              ),
              SizedBox(
                  width: context.width - 40,
                  height: 55,
                  child: const CreateNewShopSubmitButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateNewShopSubmitButton extends StatelessWidget {
  const CreateNewShopSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final createNewShopFormBloc = context.read<CreateNewShopFormBloc>();
    return ElevatedButton.icon(
      label: BlocConsumer<CreateNewShopFormBloc, SqlCreateState>(
          listenWhen: (p, c) {
        return c is SqlCreatedState || c is SqlCreateErrorState;
      }, listener: (context, state) async {
        print("state2 is $state");
        if (state is SqlCreatedState) {
          StarlightUtils.pop();
          await StarlightUtils.dialog(AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    StarlightUtils.pop();
                  },
                  child: const Text("OK"))
            ],
            title: Text(
              "${createNewShopFormBloc.form.name.input!.text} was created",
              style: const TextStyle(fontSize: 24),
            ),
          ));
          return;
        }
        if (state is SqlCreateErrorState) {
          await dialog("Failed to Create New Shop", state.message);
        }
      }, buildWhen: (p, c) {
        return c is SqlCreatedState ||
            c is SqlCreatingState ||
            c is SqlCreateErrorState;
      }, builder: (_, state) {
        logger.i("state is $state");
        if (state is SqlCreatingState) {
          return const CupertinoActivityIndicator();
        } else {
          return const Text("Create");
        }
      }),
      icon: const Icon(Icons.create),
      onPressed: () {
        createNewShopFormBloc.add(const SqlCreateEvent());
      },
    );
  }
}

class ShopCoverPhotoPicker extends StatelessWidget {
  const ShopCoverPhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<CreateNewShopFormBloc>()
            .add(const CreateNewShopPickCoverPhotoEvent());
      },
      child: BlocBuilder<CreateNewShopFormBloc, SqlCreateState>(
          builder: (_, state) {
        final path =
            context.read<CreateNewShopFormBloc>().form.coverphotopath.input ??
                "";
        return CircleAvatar(
          radius: 80,
          backgroundImage: path.isEmpty ? null : FileImage(File(path)),
          child: path.isEmpty ? const Icon(Icons.person) : null,
        );
      }),
    );
  }
}
