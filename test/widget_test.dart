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

class _PublicContainerKey extends _ContainerKey {
  _PublicContainerKey(super.key);
  factory _PublicContainerKey.fromType(Type t) {
    return _PublicContainerKey(t.toString());
  }
}

class _PrivateContainerKey extends _ContainerKey {
  _PrivateContainerKey(String key) : super("_$key");
  factory _PrivateContainerKey.fromType(Type t) {
    return _PrivateContainerKey(t.toString());
  }
}

class Container {
  (bool, _PublicContainerKey, _PrivateContainerKey) _alreadyInject(String key) {
    assert(!key.startsWith("_"));
    final publickey = _PublicContainerKey(key);
    final privatekey = _PrivateContainerKey("_key");

    return (
      store[privatekey] != null || store[publickey] != null,
      publickey,
      privatekey
    );
  }

  final Map<_ContainerKey, _ContainerValue> store = {};
  bool set<T>(String key, T value) {
    final inject = _alreadyInject(key);
    print(value);
    if (inject.$1) return false;
    store[inject.$2] = _ContainerValue(value);
    return true;
  }

  void setSingleTone<T>(T value) {
    store[_PublicContainerKey.fromType(value.runtimeType)] =
        _ContainerValue(value);
  }

  T _checkValue<T>(_ContainerKey key, _ContainerValue container) {
    if (container.value is Function && key is _PrivateContainerKey) {
      final result = container.value();
      store[key] = _ContainerValue(result);
      return result;
    }
    return container.value;
  }

  T _getContainer<T>(
      _PublicContainerKey publicKey, _PrivateContainerKey privateKey) {
    final publicvalue = store[publicKey];
    final privatevalue = store[privateKey];
    if (publicvalue == null && privatevalue == null) throw "Not found";
    if (publicvalue != null) return _checkValue(publicKey, publicvalue);

    return _checkValue(privateKey, privatevalue!);
  }

  T get<T>([String? key]) {
    print(T.toString());
    if (key == null && T.toString() == "dynamic") {
      throw "Please provide a key or type";
    }

    if (key == null) {
      return _getContainer<T>(
          _PublicContainerKey.fromType(T), _PrivateContainerKey.fromType(T));
    }
    final inject = _alreadyInject(key);
    if (!inject.$1) throw "throw does not exits";

    return _getContainer(inject.$2, inject.$3);
  }

  bool lazyset<T>(String key, T Function() value) {
    final inject = _alreadyInject(key);
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
  c.lazyset("h1", () async {
    return "future";
  });
  print(c.get("h1"));
}
