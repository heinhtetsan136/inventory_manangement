import 'package:inventory_management_app/core/db/const/sql_table_const.dart';
import 'package:inventory_management_app/core/db/interface/sql_migration.dart';
import 'package:inventory_management_app/core/db/interface/table.dart';

class SqlInventoryMigration extends SqlBaseMigration {
  SqlInventoryMigration()
      : super({
          categoriesTb: [
            const TableColumn(
              name: "name",
              type: "varchar",
              options: "not null unique",
            ),
            const TableColumn(
              name: "cover_photo",
              type: "varchar",
            )
          ],
          productTb: [
            const TableColumn(
              name: "cover_photo",
              type: "varchar",
            ),
            const TableColumn(
              name: "name",
              type: "varchar",
              options: "not null",
            ),
            const TableColumn(
              name: "category_id",
              type: "integer",
              options: "not null",
            ),
            const TableColumn(
              name: "barcode",
              type: "varchar",
              options: "unique",
            ),
          ],
          optionsTb: [
            const TableColumn(
              name: "name",
              type: "varchar",
              options: "not null",
            ),
            const TableColumn(
              name: "product_id",
              type: "integer",
              options: "not null",
            )
          ],
          valuesTb: [
            const TableColumn(
              name: "name",
              type: "varchar",
              options: "not null",
            ),
            const TableColumn(
              name: "option_id",
              type: "integer",
              options: "not null",
            )
          ],
          variantsTb: [
            const TableColumn(
              name: "product_id",
              type: "integer",
              options: "not null",
            ),
            const TableColumn(
              name: "cover_photo",
              type: "varchar",
            ),
            const TableColumn(
              name: "sku",
              type: "varchar",
              options: "not null unique",
            ),
            const TableColumn(
              name: "price",
              type: "NUMERIC",
              options: "default 0",
            ),
            const TableColumn(
              name: "on_hand",
              type: "NUMERIC",
              options: "default 0",
            ),
            const TableColumn(
              name: "damange",
              type: "NUMERIC",
              options: "default 0",
            ),
            const TableColumn(
              name: "available",
              type: "NUMERIC",
              options: "default 0",
            ),
            const TableColumn(
              name: "lost",
              type: "NUMERIC",
              options: "default 0",
            ),
          ],
          variantPropertiesTb: [
            const TableColumn(
              name: "variant_id",
              type: "integer",
              options: "not null",
            ),
            const TableColumn(
              name: "value_id",
              type: "integer",
              options: "not null",
            )
          ],
          inventoriesTb: [
            const TableColumn(
              name: "variant_id",
              type: "integer",
              options: "not null",
            ),
            const TableColumn(
              name: "reason",
              type: "text",
              options: "not null",
            ),
            const TableColumn(
              name: "quantity",
              type: "NUMERIC",
              options: "default 0",
            ),
            const TableColumn(
              name: "description",
              type: "text",
            )
          ]
        });

  @override
  // TODO: implement down
  Map<String, List<TableProperties>> get down => {};

  @override
  // TODO: implement up
  Map<String, List<TableProperties>> get up => {};
}

class SqlInventoryMigrationV1 extends SqlBaseMigration {
  SqlInventoryMigrationV1();

  @override
  // TODO: implement down
  Map<String, List<TableProperties>> get down => {};

  @override
  // TODO: implement up
  Map<String, List<TableProperties>> get up => {};
}

class SqlInventoryMigrationV2 extends SqlInventoryMigration {
  SqlInventoryMigrationV2();

  @override
  // TODO: implement down
  Map<String, List<TableProperties>> get down => {};

  @override
  // TODO: implement up
  Map<String, List<TableProperties>> get up => {
        productTb: [
          const TableColumn(
              name: "description", type: "varchar", options: " default ''"), //
        ]
      };
}

class SqlInventoryMigrationV3 extends SqlInventoryMigration {
  @override
  // TODO: implement down
  Map<String, List<TableProperties>> get down => {};

  @override
  // TODO: implement up
  Map<String, List<TableProperties>> get up => {
        productTb: [
          const TableColumn(
              name: "description", type: "varchar", options: " default ''"),
          const TableColumn(name: "photo", type: "varchar"),
        ],
        variantsTb: [
          const TableColumn(
              name: "allow_purchase_when_out_of_stock", type: "bool")
        ]
      };
}
