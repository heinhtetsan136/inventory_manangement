import 'dart:convert';

abstract class DatabaseParamModel {
  const DatabaseParamModel();
  Map<String, dynamic> tocreate();
  Map<String, dynamic> toUpdate();
}

abstract class DatabaseModel {
  const DatabaseModel();
  Map<String, dynamic> toJson();
  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
