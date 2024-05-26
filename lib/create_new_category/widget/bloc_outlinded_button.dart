import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomOutLinededButton<State extends Object,
    Bloc extends StateStreamable<State>> extends StatelessWidget {
  final Function(Bloc bloc)? _bloconPressed;
  final Function()? _onPressed;
  final bool usebloc;
  final String label;
  final Widget? Function(State state)? placeHolder;
  final IconData? icon;
  final ButtonStyle? buttonStyle;
  final bool Function(State, State)? buildWhen, listenWhen;
  final void Function(BuildContext, Bloc bloc, State)? listener;
  const CustomOutLinededButton({
    super.key,
    required Function()? onPressed,
    required this.label,
    this.icon,
    this.buttonStyle,
  })  : placeHolder = null,
        usebloc = false,
        _onPressed = onPressed,
        _bloconPressed = null,
        listenWhen = null,
        listener = null,
        buildWhen = null;
  const CustomOutLinededButton.bloc(
      {super.key,
      required Function(Bloc bloc) onPressed,
      required this.label,
      this.icon,
      this.placeHolder,
      this.buttonStyle,
      this.buildWhen,
      this.listener,
      this.listenWhen})
      : usebloc = true,
        _bloconPressed = onPressed,
        _onPressed = null;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        if (icon != null) ...[
          const SizedBox(
            width: 5,
          ),
          Icon(icon),
        ]
      ],
    );
    if (!usebloc) {
      return OutlinedButton(onPressed: _onPressed, child: child);
    }
    final bloc = context.read<Bloc>();
    return OutlinedButton(
      onPressed: () {
        _bloconPressed?.call(bloc);
      },
      child: BlocConsumer<Bloc, State>(
          listenWhen: listenWhen,
          listener: (context, state) {
            listener?.call(context, bloc, state);
          },
          buildWhen: buildWhen,
          builder: (_, state) {
            return placeHolder?.call(state) ?? child;
          }),
    );
  }
}
