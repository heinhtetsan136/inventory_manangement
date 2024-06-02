import 'package:inventory_management_app/core/db/const/sql_table_const.dart';
import 'package:inventory_management_app/core/db/interface/sql_migration.dart';
import 'package:inventory_management_app/core/db/interface/table.dart';

class SqlShopMigrationV1 extends SqlBaseMigration {
  SqlShopMigrationV1()
      : super({
          shopTb: [
            const TableColumn(name: "name", type: "varchar"),
            const TableColumn(name: "cover_photo", type: "varchar"),
          ],
        });
  @override
  // TODO: implement down
  Map<String, List<TableProperties>> get down => {};

  @override
  // TODO: implement up
  Map<String, List<TableProperties>> get up => {};
}
