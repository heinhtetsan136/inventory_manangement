// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

class _ContainerValue<T> {
  final T value;
  _ContainerValue(this.value);
}

abstract class _ContainerKey {
  final String key;
  _ContainerKey(this.key);

  @override
  operator ==(covariant _ContainerKey other) {
    return other.key == key;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => key.hashCode;
}

class _ValueKey extends _ContainerKey {
  _ValueKey(super.key);
  factory _ValueKey.fromType(Type t) {
    return _ValueKey(t.toString());
  }
}

class _LazyValueKey extends _ContainerKey {
  _LazyValueKey(String key) : super("_$key");
  factory _LazyValueKey.fromType(Type t) {
    return _LazyValueKey(t.toString());
  }
}

class Container {
  (bool, _ValueKey, _LazyValueKey) _alreadyInject(String key) {
    assert(!key.startsWith("_"));
    final valuekey = _ValueKey(key);
    final lazyvaluekey = _LazyValueKey("_key");

    return (
      store[lazyvaluekey] != null || store[valuekey] != null,
      valuekey,
      lazyvaluekey
    );
  }

  final Map<_ContainerKey, _ContainerValue> store = {};
  bool set<T>(
    T value, [
    String? instanceName,
  ]) {
    final inject = _alreadyInject(instanceName ?? T.toString());
    print(value);
    if (inject.$1) return false;
    store[inject.$2] = _ContainerValue(value);
    return true;
  }

  bool setSingleTone<T>(T value) {
    final (inject, publickey, _) = _alreadyInject(value.toString());

    if (inject) return false;
    store[publickey] = _ContainerValue(value);
    return true;
  }

  T _checkValue<T>(_ContainerKey key, _ContainerValue container) {
    if (container.value is Future && key is _LazyValueKey) {
      final result = container.value();
      store[key] = _ContainerValue(result);
      return result;
    }
    return container.value;
  }

  Future<T> _checkFutureValue<T>(
      _ContainerKey key, _ContainerValue container) async {
    if (container.value is Future && key is _LazyValueKey) {
      final result = await container.value();
      store[key] = _ContainerValue(result);
      return result;
    }
    return container.value;
  }

  T _getContainer<T>(_ValueKey valueKey, _LazyValueKey lazyvaluekey) {
    final value = store[valueKey];
    final lazyvalue = store[lazyvaluekey];
    if (value == null && lazyvalue == null) throw "Not found";
    if (value != null) return _checkValue(valueKey, value);

    return _checkValue(lazyvaluekey, lazyvalue!);
  }

  Future<T> _getFutureContainer<T>(
      _ValueKey valueKey, _LazyValueKey lazyvaluekey) async {
    final value = store[valueKey];
    final lazyvalue = store[lazyvaluekey];
    if (value == null && lazyvalue == null) throw "Not found";
    if (value != null) return _checkValue(valueKey, value);

    return _checkFutureValue(lazyvaluekey, lazyvalue!);
  }

  T get<T>([String? instanceName]) {
    print(T.toString());
    if (instanceName == null && T.toString() == "dynamic") {
      throw "Please provide a key or type";
    }

    if (instanceName == null) {
      return _getContainer<T>(_ValueKey.fromType(T), _LazyValueKey.fromType(T));
    }
    final inject = _alreadyInject(instanceName);
    if (!inject.$1) throw "throw does not exits";

    return _getContainer(inject.$2, inject.$3);
  }

  Future<T> getFuture<T>([String? instanceName]) {
    print(T.toString());
    if (instanceName == null && T.toString() == "dynamic") {
      throw "Please provide a key or type";
    }

    if (instanceName == null) {
      return _getFutureContainer<T>(
          _ValueKey.fromType(T), _LazyValueKey.fromType(T));
    }
    final inject = _alreadyInject(instanceName);
    if (!inject.$1) throw "throw does not exits";

    return _getContainer(inject.$2, inject.$3);
  }

  bool setLazy<T>(T Function() value, [String? key]) {
    final inject = _alreadyInject(key ?? T.toString());
    print(value);
    if (inject.$1) return false;
    store[inject.$3] = _ContainerValue(value);
    return true;
  }

  bool setFutureLazy<T>(Future<T> Function() value, [String? key]) {
    final inject = _alreadyInject(key ?? T.toString());
    print(value);
    if (inject.$1) return false;
    store[inject.$3] = _ContainerValue(value);
    return true;
  }
}

void main() {
  final c = Container();
  c.setSingleTone(1);

  c.set("h2", "hello world");
  c.setLazy(() async {
    return "future";
  });
  print(c.get("h1"));
}
