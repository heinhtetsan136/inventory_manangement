import 'package:inventory_management_app/core/db/interface/sql_inventory_migration.dart';
import 'package:inventory_management_app/core/db/interface/sql_shop_migration.dart';
import 'package:inventory_management_app/core/db/interface/table.dart';

const String shopDbName = "shopdatabase";
const String categoriesTb = "categories",
    productTb = "products",
    optionsTb = "options",
    valuesTb = "options_values",
    variantsTb = "variants",
    variantPropertiesTb = "variants_properties",
    inventoriesTb = "inventories",
    shopTb = "shops";
const Map<int, List<String>> tableNames = {
  1: [
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
    shopTb,
  ]
};
final SqlShopMigrationV1 _shopMigrationV1 = SqlShopMigrationV1();
Map<int, Map<String, List<TableProperties>>> get shopTableColumn =>
    {1: _shopMigrationV1.table};
final SqlInventoryMigrationV1 _inventorymigrationV1 = SqlInventoryMigrationV1();
final SqlInventoryMigrationV2 _inventoryMigrationV2 = SqlInventoryMigrationV2();
final SqlInventoryMigrationV3 _inventoryMigrationV3 = SqlInventoryMigrationV3();
Map<int, Map<String, List<TableProperties>>>
    get inventory_manangement_tableColumns => {
          1: _inventorymigrationV1.table,
          2: _inventoryMigrationV2.table,
          3: _inventoryMigrationV3.table
        };
