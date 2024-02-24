import 'package:flutter/material.dart';
import 'package:todo_app/form_todo.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/todo_list.dart';
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

  List<Todo> todos = [];


  Future<void> openTodoForm(BuildContext context) async {
    final res = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return const FormTodo();
      }
      
    );
    if (res != null) {
      print(res.id);
      setState(() {
        todos.add(res);
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
              child: const Text('Создать задачу')),
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
                    if (snapshot.data == '') {
                      // todos = [
                      //   Todo(completed: false, title: 'Купить кота', urgent: false, due: DateTime.utc(2024, 02, 25, 22, 00)),
                      //   Todo(completed: false, title: 'Сделать КТ', urgent: true, due: DateTime.utc(2024, 02, 27)),
                      //   Todo(completed: true, title: 'Вымыть машину', urgent: false, due: DateTime.utc(2024, 02, 22, 23, 00)),
                      //   Todo(completed: false, title: 'Разобраться с DateTime', urgent: true, due: DateTime.utc(2024, 02, 24, 21, 00)),
                      //   Todo(completed: false, title: 'Разобраться с Flutter', urgent: true, due: DateTime.utc(2024, 02, 26, 23, 00)),
                      //   Todo(completed: false, title: 'Разобраться с DateTime', urgent: true, due: DateTime.utc(2024, 02, 23, 21, 00)),
                      //   Todo(completed: false, title: 'Разобраться с JS', urgent: true, due: DateTime.utc(2024, 02, 2, 23, 00))
                      // ];
                      return SingleChildScrollView(child: TodoList(todos: todos));
                    } else {
                      return const Text('no todos');
                    }
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

// Future<void> getDate(BuildContext context) async {
  //   final res = await showDatePicker(
  //     context: context,
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime.now().add(const Duration(days: 730))
  //   );
  // }


//  SizedBox(
        //   width: double.infinity,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       const SizedBox(height: 40),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 16, right: 16),
        //         child: TextField(
        //           decoration: const InputDecoration(
        //             border: OutlineInputBorder(),
        //             labelText: 'Задача'
        //           ),
        //           controller: TextEditingController(),
        //           onChanged: (String value) {title = value;},
        //         ),
        //       ),
        //       const SizedBox(height: 20),
        //       OutlinedButton(
        //         onPressed: () {getDate(context);},
        //         child: const Text('Выбрать дату')
        //         ),
        //       ElevatedButton(
        //         onPressed:() {},
        //         child: const Text('Добавить'))
        //     ]
        //   ),
        // );
