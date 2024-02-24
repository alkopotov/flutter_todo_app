abstract class AbstractLocalStorage {
  String get key;

  Future<void> writeData(String data);

  Future<String> readData();

  Future<void> deleteData();
}