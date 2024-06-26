import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/utils/dialog.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_engine/dasgboard_engine_state.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_engine/dashboard_engine_bloc.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:starlight_utils/starlight_utils.dart';

class DashBoardLoader extends StatelessWidget {
  const DashBoardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashBoardEngineBloc, DashboardEngineState>(
      listenWhen: (p, c) {
        return c is DashboardEngineErrorState || c is DashboardEngineRadyState;
      },
      listener: (_, state) async {
        print("state is $state");
        if (state is DashboardEngineRadyState) {
          StarlightUtils.pushNamed(
            RouteNames.dashboard,
          );
        }
        if (state is DashboardEngineErrorState) {
          await dialog("Failed to Load DashBoard", state.message);
          StarlightUtils.pushReplacementNamed(RouteNames.shopList);
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.horizontalRotatingDots(
                  color: Colors.blue, size: 40),
              const Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 20),
                child: Text("This may take a few minute"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
