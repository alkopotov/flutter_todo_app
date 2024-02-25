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


  Future<void> openTodoForm(BuildContext context) async {
    final res = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return const FormTodo();
      }
    );
    if (res != null) {

      setState((){
        todos.addTodo(res);
        todos.itemsFromJson(todos.jsonTodos);


        // var todosObjsJson = jsonDecode(todos.jsonTodos) as List;
        // ListTodo sample = ListTodo();
        // for (var e in jsonDecode(todos.jsonTodos)) {
        //   sample.addTodo(Todo.fromJson(e));
        // }
        // print(sample);

        // var newTodos = jsonDecode(todos.jsonTodos).map((e)=> Todo.fromJson(e)).toList();
        // print(newTodos);
        // print(todos.itemsFronJson(todosObjsJson));

        // print(todos.jsonTodos);
        // print(jsonDecode(todos.jsonTodos));
        // print(todos.itemsFronJson(jsonDecode(todos.jsonTodos)));

        // print(todos.itemsFronJson(jsonDecode(todos.jsonTodos)));

        // print(
        //   Todo.fromJson(jsonDecode(todos.jsonTodos)[0])
        // );

      });
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
