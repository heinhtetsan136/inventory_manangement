import 'package:inventory_management_app/core/db/interface/table.dart';

String toSqlQuery(TableProperties properties) {
  if (properties is TableColumn) {
    return "${properties.name} ${properties.type} ${properties.options},";
  }
  if (properties is TableForeignKey) {
    return "foreign key ${properties.fColumn} references ${properties.table}(${properties.tblColumn},)";
  }
  throw UnimplementedError();
}
