import 'package:flutter/material.dart';
import 'package:todo_app/models/days_word.dart';
import 'package:todo_app/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 600,
      child: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: widget.todos.length,
          itemBuilder: (BuildContext context, index) {

            return Container(
              height: 36,
            
              decoration: BoxDecoration(
                color: (
                  widget.todos[index].completed ? Colors.green[200]: 
                  widget.todos[index].due.difference(DateTime.now()).inDays <= 0 ? Colors.red[800] :
                  widget.todos[index].due.difference(DateTime.now()).inDays > 3 ? Colors.amber[100] :
                  Colors.pink[900 - widget.todos[index].due.difference(DateTime.now()).inDays * 200]
                  ),

                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 5, top: 0, bottom: 0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.todos[index].title} ${DaysToWord(days: widget.todos[index].due.difference(DateTime.now()).inDays).text()}.'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: widget.todos[index].completed,
                        onChanged: (bool? value) {
                          setState(() {
                          widget.todos[index].switchCompleted();
                          });
                      }),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.delete),
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
