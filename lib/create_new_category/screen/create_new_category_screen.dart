import 'package:flutter/material.dart';

class CreateNewCategoryScreen extends StatelessWidget {
  const CreateNewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Categories"),
      ),
      body: Form(
        child: Column(
          children: [
            const Text("Name"),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
