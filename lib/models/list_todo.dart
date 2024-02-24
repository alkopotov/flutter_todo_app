import 'package:todo_app/models/todo.dart';

class ListTodo {

  final List<Todo> _items = [];
  
  int get itemsNumber {
    return _items.length;
  }

  List<Todo> get items {
    return _items;
  }

  void addTodo(Todo todo){
    _items.add(todo);
  }

  List<Todo> getTodos() {
    return _items;
  }

  void deleteTodoById(String id) {
    _items.removeWhere((element) => element.id == id);
  }
  void deleteTodoByIndex(ind) {
    _items.removeAt(ind);
  }

}
