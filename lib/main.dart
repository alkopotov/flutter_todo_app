import 'package:flutter/material.dart';
import 'package:todo_app/form_todo.dart';
import 'package:todo_app/models/list_todo.dart';
import 'package:todo_app/todos_list_widget.dart';
import 'package:todo_app/todos_local_storage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Список задач'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  TodosLocalStorage todosLocalStorage = TodosLocalStorage();

  ListTodo todos = ListTodo();

  Future<void> addTodo(todo) async {
    await todos.addTodo(todo);
    setState((){
        todos.itemsFromJson(todos.jsonTodos);
      });
  }

  Future<void> openTodoForm(BuildContext context) async {
    final res = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return const FormTodo();
      }
    );
    if (res != null) {
      addTodo(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 20),
             ElevatedButton(
              onPressed: () {openTodoForm(context);},
              child: const Text('Создать задачу')
              ),
             FutureBuilder(
                future: todosLocalStorage.readData(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data != '') {
                        todos.itemsFromJson(snapshot.data);
                      }
                      return SingleChildScrollView(child: TodoList(todos: todos));
                    }
                }
                return const Text('Unknown error');
                }
              ),
            ]
          ),
        ),
    );
  }
}
