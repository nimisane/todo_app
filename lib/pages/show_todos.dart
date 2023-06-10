import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/blocs.dart';

import '../models/todos_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  List<Todos> setFilterTodos(
      Filter filter, List<Todos> todos, String searchTerm) {
    List<Todos> _filteredtodos;

    switch (filter) {
      case Filter.active:
        _filteredtodos =
            todos.where((Todos element) => !element.completed).toList();

        break;

      case Filter.completed:
        _filteredtodos =
            todos.where((Todos element) => element.completed).toList();

        break;

      case Filter.all:
      default:
        _filteredtodos = todos;

        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredtodos = _filteredtodos
          .where((Todos Todos) =>
              Todos.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    return _filteredtodos;
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilterTodoBlocBloc>().state.filterTodos;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(listener: (context, state) {
          final filteredTodos = setFilterTodos(
              context.read<TodoFilterBloc>().state.filter,
              state.todos,
              context.read<TodoSearchBloc>().state.searchTerm);
          context
              .read<FilterTodoBlocBloc>()
              .add(FilteredTodoEvent(filteredTodos: filteredTodos));
        }),

        BlocListener<TodoFilterBloc, TodoFilterState>(listener: (context, state) {
          final filteredTodos = setFilterTodos(
              state.filter,
              context.read<TodoListBloc>().state.todos,
              context.read<TodoSearchBloc>().state.searchTerm);
          context
              .read<FilterTodoBlocBloc>()
              .add(FilteredTodoEvent(filteredTodos: filteredTodos));
        }),
         BlocListener<TodoSearchBloc, TodoSearchState>(listener: (context, state) {
          final filteredTodos = setFilterTodos(
              context.read<TodoFilterBloc>().state.filter,
              context.read<TodoListBloc>().state.todos,
              state.searchTerm);
          context
              .read<FilterTodoBlocBloc>()
              .add(FilteredTodoEvent(filteredTodos: filteredTodos));
        }),
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
              context
                  .read<TodoListBloc>()
                  .add(RemoveTodoEvent(id: todos[index].id));
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
            context
                .read<TodoListBloc>()
                .add(ToggleTodoEvent(id: widget.todos.id));
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
