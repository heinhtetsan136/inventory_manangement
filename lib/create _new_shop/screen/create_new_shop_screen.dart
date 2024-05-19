import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_bloc.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_event.dart';
import 'package:inventory_management_app/create%20_new_shop/controller/create_new_shop_state.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:starlight_utils/starlight_utils.dart';

class CreateNewShopScreen extends StatelessWidget {
  const CreateNewShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createNewShopbloc = context.read<CreateNewShopBloc>();
    final middleWidth = context.width * 0.14;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: createNewShopbloc.formkey,
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
                  controller: createNewShopbloc.controller,
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
    final createNewShopbloc = context.read<CreateNewShopBloc>();
    return ElevatedButton.icon(
      label: BlocConsumer<CreateNewShopBloc, CreateNewShopState>(
          listenWhen: (p, c) {
        return c is CreateNewShopCreatedState || c is CreateNewShopErrorState;
      }, listener: (context, state) {
        print("state is $state");
        if (state is CreateNewShopCreatedState) {
          StarlightUtils.pop();
          StarlightUtils.dialog(AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    StarlightUtils.pop();
                  },
                  child: const Text("OK"))
            ],
            title: Text(
              "${createNewShopbloc.controller.text} was created",
              style: const TextStyle(fontSize: 24),
            ),
          ));
          return;
        }
        if (state is CreateNewShopErrorState) {
          StarlightUtils.pop();
          StarlightUtils.dialog(AlertDialog(actions: [
            TextButton(
                onPressed: () {
                  StarlightUtils.pop();
                },
                child: const Text("OK"))
          ], content: const Text("Please choose a picture")));
        }
      }, buildWhen: (p, c) {
        return c is CreateNewShopCreatedState ||
            c is CreateNewShopCreatingState ||
            c is CreateNewShopErrorState;
      }, builder: (_, state) {
        logger.i("state is $state");
        if (state is CreateNewShopCreatingState) {
          return const CupertinoActivityIndicator();
        } else {
          return const Text("Create");
        }
      }),
      icon: const Icon(Icons.create),
      onPressed: () {
        createNewShopbloc.add(const CreateNewShopCreateShopEvent());
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
            .read<CreateNewShopBloc>()
            .add(const CreateNewShopPickCoverPhotoEvent());
      },
      child:
          BlocBuilder<CreateNewShopBloc, CreateNewShopState>(buildWhen: (p, c) {
        return p.coverPhotoPath?.split("/").last !=
            c.coverPhotoPath?.split("/").last;
      }, builder: (_, state) {
        final path = state.coverPhotoPath ?? "";
        return CircleAvatar(
          radius: 80,
          backgroundImage: path.isEmpty ? null : FileImage(File(path)),
          child: path.isEmpty ? const Icon(Icons.person) : null,
        );
      }),
    );
  }
}
