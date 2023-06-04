import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/blocs.dart';

class CreateTodo extends StatefulWidget {
  CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create a task",
            style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              TextFormField(
                controller: todoController,
                decoration: const InputDecoration(
                  hintText: "What to do",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (todoController.text.trim().isNotEmpty) {
                      context
                          .read<TodoListBloc>().add(AddTodoEvent(todoDesc: todoController.text));
                          // .addTodo(todoController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todoController.dispose();

    super.dispose();
  }
}
