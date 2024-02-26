import 'package:todo_app/models/todo.dart';
import 'dart:convert';
import 'package:todo_app/todos_local_storage.dart';

class ListTodo {

  List<Todo> _items = [];
  
  int get itemsNumber {
    return _items.length;
  }

  

  List<Todo> get items {
    return _items;
  }

 Future<void> addTodo(Todo todo) async{
    _items.add(todo);
    await TodosLocalStorage().writeData(jsonTodos);
  }

  List<Todo> getTodos() {
    return _items;
  }

  Future<void> deleteTodoById(String id) async{
    _items.removeWhere((element) => element.id == id);
    await TodosLocalStorage().writeData(jsonTodos);
  }

  Future<void> deleteTodoByIndex(ind) async{
    _items.removeAt(ind);
    await TodosLocalStorage().writeData(jsonTodos);
  }

  String get jsonTodos{
    List todosStr = _items.map((i) => i.toJson()).toList();
    return jsonEncode(todosStr);
  }

  void itemsFromJson(json) {
    _items = [];
    for (var elem in jsonDecode(json)) {
      _items.add(Todo.fromJson(elem));
    }
  }
}