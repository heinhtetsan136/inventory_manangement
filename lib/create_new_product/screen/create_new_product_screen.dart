import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/category/controller/category_list_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_create_event.dart';
import 'package:inventory_management_app/core/bloc/sql_create_state.dart';
import 'package:inventory_management_app/create_new_product/controller/create_new_product_bloc.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:inventory_management_app/theme/theme.dart';
import 'package:inventory_management_app/widget/box/form_box.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';
import 'package:starlight_utils/starlight_utils.dart';

class CreateNewProductScreen extends StatelessWidget {
  const CreateNewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = context.theme.appBarTheme.titleTextStyle;
    final bodyLargeTextStyle = StandardTheme.getBodyTextStyle(context);
    final categoryListBloc = context.read<CategoryListBloc>();
    final createNewProductBloc = context.read<CreateNewProductBloc>();
    return Theme(
      data: context.theme.copyWith(
          listTileTheme: context.theme.listTileTheme.copyWith(
              iconColor: context.theme.primaryColor,
              textColor: context.theme.primaryColor)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Product"),
          actions: [
            CustomOutLinededButton<SqlCreateState, CreateNewProductBloc>.bloc(
              buildWhen: (p, c) {
                logger.e(p.toString());
                logger.e(c.toString());
                return false;
              },
              onPressed: (bloc) {
                bloc.form.name.input?.text = "Product1";
                bloc.form.barcode.input?.text = "Product1";
                bloc.form.categoryId.input = 1;
                bloc.form.description.input?.text = "dss";
                bloc.add(const SqlCreateEvent());
              },
              label: "Save",
              icon: Icons.save,
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 30),
          children: [
            FormBox(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product Photo", style: titleTextStyle),
                    Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                      width: 80,
                      height: 80,
                      // child:Icon(Icons.)
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.theme.unselectedWidgetColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.upload,
                        size: 30,
                      ),
                    ),
                    Text("Product Title", style: titleTextStyle),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Shoes etc...",
                        ),
                      ),
                    ),
                    Text("Description", style: titleTextStyle),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextFormField(
                        maxLines: 5,
                        minLines: 3,
                        decoration: const InputDecoration(
                          hintText: "Enter a descriptions ...",
                        ),
                      ),
                    ),
                    Text(
                      "Describe your product attributes,sales etc ... ",
                      style: bodyLargeTextStyle,
                    )
                  ],
                )),
            ListTile(
              onTap: () async {
                print("add");
                final result = await StarlightUtils.pushNamed(
                    RouteNames.addCategoryScreen,
                    arguments: categoryListBloc);

                print(result?.id);
              },
              leading: const Icon(
                Icons.category_outlined,
              ),
              title: const Text(
                "Category",
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                onTap: () async {
                  print("add");
                  final result = await StarlightUtils.pushNamed(
                      RouteNames.addCategoryScreen,
                      arguments: categoryListBloc);

                  print(result?.id);
                },
                leading: const Icon(
                  Icons.archive_outlined,
                ),
                title: const Text(
                  "Add Variants",
                  style: TextStyle(),
                ),
              ),
            ),
            FormBox(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.inventory_outlined),
                      title: const Text("Inventory"),
                      trailing: TextButton(
                          onPressed: () {
                            StarlightUtils.pushNamed(
                                RouteNames.setProductInventory,
                                arguments: createNewProductBloc);
                          },
                          child: const Text("Edit")),
                    ),
                    KeyValuePairWidget(
                        leading: Text(
                          "SKU",
                          style: bodyLargeTextStyle,
                        ),
                        trailing: const Text(
                          "data",
                          textAlign: TextAlign.end,
                        )),
                    KeyValuePairWidget(
                        leading: Text(
                          "Barcode",
                          style: bodyLargeTextStyle,
                        ),
                        trailing: const Text(
                          "data",
                          textAlign: TextAlign.end,
                        )),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: true,
                      onChanged: (value) {},
                      title: const Text("Allow Purchase When Out of Stock"),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StockValue(title: "Avaiable", value: 0),
                        StockValue(title: "On Hand", value: 0),
                        StockValue(title: "Lost", value: 0),
                        StockValue(title: "Damage", value: 0),
                      ],
                    )
                  ],
                )),
            ListTile(
              onTap: () async {
                final price = await StarlightUtils.pushNamed(
                    RouteNames.setProductPriceScreen,
                    arguments: createNewProductBloc);
                print("price $price");
              },
              leading: const Icon(
                Icons.monetization_on,
              ),
              title: const Text(
                "Price",
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeyValuePairWidget extends StatelessWidget {
  final Widget leading, trailing;
  const KeyValuePairWidget(
      {super.key, required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: leading),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: trailing,
        )),
      ],
    );
  }
}

class StockValue extends StatelessWidget {
  const StockValue({super.key, required this.title, required this.value});
  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$value",
              style: StandardTheme.getBodyTextStyle(context),
            ),
            const Icon(Icons.arrow_drop_down_outlined),
          ],
        ),
      ],
    );
  }
}
