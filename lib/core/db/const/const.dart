import 'package:inventory_management_app/core/db/interface/table.dart';

const String categoriesTb = "categories",
    productTb = "products",
    optionsTb = "options",
    valuesTb = "options_values",
    variantsTb = "variants",
    variantPropertiesTb = "variants_properties",
    inventoriesTb = "inventories";

const List<String> tableNames = [
  ///categories
  categoriesTb,

  ///product,
  productTb,

  ///options,
  optionsTb,

  ///options_values
  valuesTb,

  ///variants
  variantsTb,

  ///variants_properties
  variantPropertiesTb,

  ///inventory
  inventoriesTb,
];
const Map<String, List<TableProperties>> tableColumn = {
  categoriesTb: [
    TableColumn(
      name: "name",
      type: "varchar",
      options: "not null unique",
    ),
    TableColumn(
      name: "cover_photo",
      type: "varchar",
    )
  ],
  productTb: [
    TableColumn(
      name: "cover_photo",
      type: "varchar",
    ),
    TableColumn(
      name: "name",
      type: "varchar",
      options: "not null",
    ),
    TableColumn(
      name: "category_id",
      type: "integer",
      options: "not null",
    ),
    TableColumn(
      name: "barcode",
      type: "varchar",
      options: "unique",
    ),
  ],
  optionsTb: [
    TableColumn(
      name: "name",
      type: "varchar",
      options: "not null",
    ),
    TableColumn(
      name: "product_id",
      type: "integer",
      options: "not null",
    )
  ],
  valuesTb: [
    TableColumn(
      name: "name",
      type: "varchar",
      options: "not null",
    ),
    TableColumn(
      name: "option_id",
      type: "integer",
      options: "not null",
    )
  ],
  variantsTb: [
    TableColumn(
      name: "product_id",
      type: "integer",
      options: "not null",
    ),
    TableColumn(
      name: "cover_photo",
      type: "varchar",
    ),
    TableColumn(
      name: "sku",
      type: "varchar",
      options: "not null unique",
    ),
    TableColumn(
      name: "price",
      type: "NUMERIC",
      options: "default 0",
    ),
    TableColumn(
      name: "on_hand",
      type: "NUMERIC",
      options: "default 0",
    ),
    TableColumn(
      name: "damange",
      type: "NUMERIC",
      options: "default 0",
    ),
    TableColumn(
      name: "lost",
      type: "NUMERIC",
      options: "default 0",
    ),
  ],
  variantPropertiesTb: [
    TableColumn(
      name: "variant_id",
      type: "integer",
      options: "not null",
    ),
    TableColumn(
      name: "value_id",
      type: "integer",
      options: "not null",
    )
  ],
  inventoriesTb: [
    TableColumn(
      name: "variant_id",
      type: "integer",
      options: "not null",
    ),
    TableColumn(
      name: "reason",
      type: "text",
      options: "not null",
    ),
    TableColumn(
      name: "quantity",
      type: "NUMERIC",
      options: "default 0",
    ),
    TableColumn(
      name: "description",
      type: "text",
    )
  ]
};
