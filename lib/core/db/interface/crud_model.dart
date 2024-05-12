abstract class DatabaseParamModel {
  const DatabaseParamModel();
  Map<String, dynamic> toCreate();
  Map<String, dynamic> toUpdate();
}

abstract class DatabaseModel {
  const DatabaseModel();
}
