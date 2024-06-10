import 'package:flutter/widgets.dart';
import 'package:inventory_management_app/core/bloc/sql_create_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_create_event.dart';
import 'package:inventory_management_app/core/bloc/sql_create_state.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';

class CreateBlocOutLinedButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Widget? Function(SqlCreateState)? placeHolder;
  const CreateBlocOutLinedButton(
      {super.key, required this.label, this.icon, this.placeHolder});

  @override
  Widget build(BuildContext context) {
    return CustomOutLinededButton<SqlCreateState, SqlCreateBloc>.bloc(
      onPressed: (bloc) {
        bloc.add(const SqlCreateEvent());
      },
      placeHolder: placeHolder,
      label: label,
      icon: icon,
    );
  }
}
