class BasicState {
  final DateTime _dateTime;
  BasicState() : _dateTime = DateTime.now();
  @override
  bool operator ==(covariant BasicState other) {
    return other._dateTime.toIso8601String() == _dateTime.toIso8601String() &&
        other.runtimeType == runtimeType;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => _dateTime.hashCode + runtimeType.hashCode;
}
