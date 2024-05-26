import 'package:flutter/material.dart';
import 'package:starlight_utils/starlight_utils.dart';

class FormBox extends StatelessWidget {
  final EdgeInsetsGeometry? padding, margin;
  final double? width, height;
  final Widget? child;
  const FormBox(
      {super.key,
      this.padding,
      this.margin,
      required this.child,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(20),
      margin: margin,
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: child,
    );
  }
}
