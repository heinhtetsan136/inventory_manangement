import 'package:flutter/material.dart';
import 'package:starlight_utils/starlight_utils.dart';

class FormBox extends StatelessWidget {
  final EdgeInsetsGeometry? padding, margin;
  final GlobalKey<FormState>? formkey;
  final Widget? child;
  const FormBox(
      {super.key,
      this.padding,
      this.margin,
      this.formkey,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        margin: margin,
        decoration: BoxDecoration(color: context.theme.cardColor),
        child: child,
      ),
    );
  }
}
