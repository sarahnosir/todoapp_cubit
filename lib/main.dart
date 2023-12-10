import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TodoCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => context.read<TodoCubit>().toggleTodo(index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  final controller = TextEditingController();
                  return AlertDialog(
                    title: Text('Add Task'),
                    content: TextField(
                      controller: controller,
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              context
                                  .read<TodoCubit>()
                                  .addTodo(controller.text);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Add Task')),
                    ],
                  );
                })),
        FloatingActionButton(
            onPressed: () => context.read<TodoCubit>().clearCompleted(),
            child: Icon(Icons.delete)),
      ]),
    );
  }
}
