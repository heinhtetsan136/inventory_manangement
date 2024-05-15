abstract class DataStore<D> {
  late final D? database;
  Future<void> connect();
  Future<void> OnUp(int version, [D? db]);
  Future<void> OnDown(int old, current, [D? db]);
  Future<void> close();
}
