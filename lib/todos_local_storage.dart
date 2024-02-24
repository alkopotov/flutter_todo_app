import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app/abstract_local_storage.dart';

class TodosLocalStorage implements AbstractLocalStorage {

  FlutterSecureStorage todoStorage = const FlutterSecureStorage();

  @override
  Future<void> writeData(String data) async {
    await todoStorage.write(key: key, value: data);
  }

  @override
  Future<String> readData() async {
    return await todoStorage.read(key: key) ?? '';
  }

  @override
  Future<void> deleteData() async {
    await todoStorage.delete(key: key);
  }

  @override
  String get key => 'todos';
}