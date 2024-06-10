import 'package:flutter/material.dart';
import 'package:starlight_utils/starlight_utils.dart';

class FormBox extends StatelessWidget {
  final EdgeInsetsGeometry? padding, margin;
  final double? width, height;
  final Widget? child;
  final AlignmentGeometry? alignment;
  const FormBox(
      {super.key,
      this.alignment,
      this.padding,
      this.margin,
      required this.child,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
      ),
      alignment: alignment,
      child: child,
    );
  }
}
