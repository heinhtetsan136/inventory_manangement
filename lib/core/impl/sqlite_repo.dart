import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/core/db/interface/database_crud.dart';
import 'package:sqflite/sqflite.dart';

class sqliteRepo<Model extends DatabaseModel,
        ModelParams extends DatabaseParamModel>
    implements DatabaseCrud<Database, Model, ModelParams> {
  @override
  final DataStore<Database> store;
  @override
  final String tableName;
  final Model Function(dynamic data) parser;
  sqliteRepo(this.store, this.parser, this.tableName);

  @override
  Future<Model?> create(ModelParams values) async {
    final payload = values.tocreate();
    final mapkey = payload.keys.map((e) {
      return " ${e.toString()}";
    });
    payload.addEntries({MapEntry("created_At", DateTime.now())});

    final insertedId = await database
        .rawInsert('''insert into "$tableName" (${payload.keys.join(",")}) 
        values (${payload.values.map((e) => "'$e'").join(",")})''');
    // final result = await database.insert(tableName, map);
    print("result $insertedId");
    return get(insertedId);

    // if (result.isEmpty) return null;
    // return Category.fromJson(result.first);
  }

  @override
  Future<Model?> delete(int id) async {
    final model = get(id);
    final int effectedrow = await database
        .rawDelete("""delete from "$tableName" where id =?""", [id]);
    if (effectedrow < 1) return null;
    print("detleted $effectedrow");
    return model;
  }

  @override
  Future<Model?> update(int id, ModelParams values) async {
    final payload = values.toUpdate();

    payload.addEntries({MapEntry("created_At", DateTime.now())});
    final dataset = payload.keys.map((column) {
      return "$column ='${payload[column]}'";
    }).join(",");
    final effectedrow = await database
        .rawInsert('''update "$tableName" set $dataset where id = $id 
        ''');
    // final result = await database.insert(tableName, map);
    if (effectedrow < 1) return null;
    print("result $effectedrow");
    return get(effectedrow);
  }

  @override
  // TODO: implement database
  Database get database => store.database!;

  @override
  Future<Model?> get(int id) async {
    final result = await database.rawQuery("""$query where id=$id limit 1""");
    print("get $result");

    return parser(result.first);
  }

  bool useRef = false;
  String get query {
    print("useRef $useRef");
    return useRef ? refQuery : nonRefQuery;
  }

  String get nonRefQuery {
    return """select * from $tableName """;
  }

  String get refQuery {
    return """select * from $tableName""";
  }

  Future<List<Model>?> findModel({
    int limit = 20,
    int offset = 0,
    String? where,
    bool useRef = false,
  }) {
    this.useRef = useRef;
    return _find(limit, offset, where);
  }

  Future<Model?> getOne(int id, [bool useRef = false]) {
    this.useRef = useRef;
    return get(id);
  }

  @override
  Future<List<Model>?> _find(
      [int limit = 1, int offset = 0, String? where]) async {
    print("query $query");
    final result = await database
        .rawQuery("""$query ${where ?? ""}limit $offset,$limit  """);
    return result.map(parser).toList();
  }
}
