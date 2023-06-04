import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubits/cubits.dart';

import '../models/todos_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilterTodosCubit>().state.filterTodos;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            context.read<FilterTodosCubit>().setFilterTodos(
                  context.read<TodoFilterCubit>().state.filter,
                  state.todos,
                  context.read<TodoSearchCubit>().state.searchTerm,
                );
          },
        ),
        BlocListener<TodoFilterCubit, TodoFilterState>(
          listener: (context, state) {
            context.read<FilterTodosCubit>().setFilterTodos(
                  state.filter,
                  context.read<TodoListCubit>().state.todos,
                  context.read<TodoSearchCubit>().state.searchTerm,
                );
          },
        ),
        BlocListener<TodoSearchCubit, TodoSearchState>(
          listener: (context, state) {
            context.read<FilterTodosCubit>().setFilterTodos(
                  context.read<TodoFilterCubit>().state.filter,
                  context.read<TodoListCubit>().state.todos,
                  state.searchTerm,
                );
          },
        ),
      ],
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(todos[index].id),
            background: showBackgrond(0),
            secondaryBackground: showBackgrond(1),
            child: TodoItem(
              todos: todos[index],
            ),
            onDismissed: (_) {
              context.read<TodoListCubit>().removeTodos(todos[index]);
            },
            confirmDismiss: (_) {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text("Do you really want to delete?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("NO"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("YES"),
                        ),
                      ],
                    );
                  });
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
          );
        },
        itemCount: todos.length,
      ),
    );
  }

  Widget showBackgrond(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todos todos;
  TodoItem({super.key, required this.todos});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todos.completed,
        onChanged: (bool? value) {
          if (value != null) {
            context.read<TodoListCubit>().toggleTodos(widget.todos.id);
          }
        },
      ),
      title: Text(
        widget.todos.desc,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
