import 'package:flutter/material.dart';
import 'package:starlight_utils/starlight_utils.dart';

Future<T?> dialog<T>(String title, String content, [Function()? call]) =>
    StarlightUtils.dialog<T>(AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              call ?? StarlightUtils.pop();
            },
            child: const Text("OK"))
      ],
    ));
