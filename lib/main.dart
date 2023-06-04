import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/blocs.dart';

import 'pages/todos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(
          create: (context) => TodoFilterBloc(),
        ),
        BlocProvider<TodoSearchBloc>(
          create: (context) => TodoSearchBloc(),
        ),
        BlocProvider<TodoListBloc>(
          create: (context) => TodoListBloc(),
        ),
        BlocProvider<ActiveTodoCountBlocBloc>(
          create: (context) => ActiveTodoCountBlocBloc(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todos.length,
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
        BlocProvider<FilterTodoBlocBloc>(
          create: (context) => FilterTodoBlocBloc(
              initialTodos: context.read<TodoListBloc>().state.todos,
              todoListBloc: BlocProvider.of<TodoListBloc>(context),
              todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
              todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'To Do Bloc App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Todospage(),
      ),
    );
  }
}
