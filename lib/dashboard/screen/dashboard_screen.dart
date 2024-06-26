import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/category/view/category_list_view.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_navigation/dashboard_navigation_bloc.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_navigation/dashboard_navigation_event.dart';
import 'package:inventory_management_app/dashboard/controller/dashboard_navigation/dashboard_navigation_state.dart';
import 'package:inventory_management_app/product/view/product_list_view.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationbloc = context.read<DashBoardNavigationBloc>();
    return Scaffold(
      body: BlocBuilder<DashBoardNavigationBloc, DashboardNavigationSate>(
          builder: (_, state) {
        return [
          const CategoryListView(),
          const CategoryListView(),
          const ProductListView(),
          const CategoryListView(),
        ][state.i];
      }),
      bottomNavigationBar:
          BlocBuilder<DashBoardNavigationBloc, DashboardNavigationSate>(
              builder: (_, state) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.precision_manufacturing), label: "Product"),
            BottomNavigationBarItem(
                icon: Icon(Icons.inventory), label: "Inventory")
          ],
          onTap: (v) {
            navigationbloc.add(DashBoardNavigationEvent(v));
          },
          currentIndex: state.i,
        );
      }),
    );
  }
}
