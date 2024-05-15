abstract class DatabaseParamModel {
  const DatabaseParamModel();
  Map<String, dynamic> toCreate();
  Map<String, dynamic> toUpdate();
}

class ResultException implements Exception {
  final String message;
  final StackTrace? stracttrace;
  ResultException(this.message, [this.stracttrace]);
}

class Result<T> {
  @override
  String toString() {
    // TODO: implement toString
    if (_exception != null) return _exception.message;
    return _result.toString() ?? "";
  }

  final T? _result;
  final ResultException? _exception;

  Result({T? result, ResultException? exception})
      : _exception = exception,
        _result = result,
        assert(result != null || exception != null);
  bool get hasError => _exception != null;
  T? get result {
    assert(_exception == null);
    return _result;
  }

  ResultException? get exception {
    assert(_result == null);
    return _exception;
  }
}

abstract class DatabaseModel {
  final int id;
  @override
  bool operator ==(covariant DatabaseModel other) {
    return other.id == id && other.id.runtimeType == id.runtimeType;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id & runtimeType.hashCode;

  const DatabaseModel({required this.id});
}
