abstract class DataStore<D> {
  late final D? database;
  Future<void> connect();
  Future<void> OnUp([D? db]);
  Future<void> OnDown([D? db]);
  Future<void> close();
}
