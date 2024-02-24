import 'package:flutter/material.dart';
import 'package:todo_app/models/list_todo.dart';
import 'package:todo_app/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.todos});

  final ListTodo todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  String todoText(Todo todo) {
    return '';
  }

  Color todoColor(Todo todo) {
  
    return Colors.red;
  }

  Color todoTextColor(Todo todo) {
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 600,
      child: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: widget.todos.itemsNumber,
          itemBuilder: (BuildContext context, index) {
            return Container(
              height: 36,
              decoration: BoxDecoration(
                color: widget.todos.items[index].todoColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 3, right: 6, top: 0, bottom: 0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Checkbox(
                        value: widget.todos.items[index].completed,
                        onChanged: (bool? value) {
                          setState(() {
                          widget.todos.items[index].switchCompleted();
                          });
                      }),
                  Text(
                    widget.todos.items[index].todoText,
                    style: TextStyle(
                      color: widget.todos.items[index].todoTextColor,
                      fontSize: 17),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.todos.deleteTodoByIndex(index);
                          });
                        },
                        child: Icon(
                          Icons.delete_outline_outlined,
                          color: widget.todos.items[index].todoTextColor,
                        ),
                      )
                    ],
                  ),
                ],
              )));
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
      )
      );
  }
}
