import 'package:uuid/uuid.dart';

var uuid =  const Uuid();

class Todo {
  
  Todo({
    required this.title,
    required this.completed,
    required this.due,
    required this.urgent
  });
  String id = uuid.v1();
  String title;
  bool completed;
  DateTime due;
  bool urgent;

  void switchCompleted() {
    completed = !completed;
  }
}