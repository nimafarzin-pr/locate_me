abstract class IDBCrud<T, C> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<int> insert(C item);
  Future<void> update(int id, C item);
  Future<int> delete(int id);
  Stream<List<T>> watchAll();
}
