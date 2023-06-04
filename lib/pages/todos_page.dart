import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/pages/create_todo.dart';
import 'package:to_do_app/pages/show_todos.dart';

import '../cubits/active_todo_count/active_todo_count_cubit.dart';
import 'search_and_filter_todo.dart';

class Todospage extends StatelessWidget {
  const Todospage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateTodo()));
            },
            child: const Icon(Icons.add)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                const TodoHeader(),
                const SizedBox(
                  height: 20,
                ),
                SearchAndFilterTodo(),
                const SizedBox(
                  height: 20,
                ),
                const ShowTodos(),
              ],
            ),
          ),
        ));
  }
}

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "TODO",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
        ),
        Text(
          "${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left",
          style: const TextStyle(fontSize: 20, color: Colors.redAccent),
        ),
      ],
    );
  }
}
