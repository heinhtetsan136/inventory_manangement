abstract class TableProperties {}

class TableForeignKey implements TableProperties {
  final String fColumn;
  final String table;

  ///other table
  final String tblColumn;

  TableForeignKey(this.fColumn, this.table, this.tblColumn);
}

class TableColumn implements TableProperties {
  final String name;
  final String type;
  final String options;

  const TableColumn({
    required this.name,
    required this.type,
    this.options = "",
  });
}
