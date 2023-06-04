// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:to_do_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:to_do_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:to_do_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:to_do_app/models/todos_model.dart';

part 'filter_todos_state.dart';

class FilterTodosCubit extends Cubit<FilterTodosState> {
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  final List<Todos> initialTodos;

  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoListSubscription;

  FilterTodosCubit({
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
    required this.initialTodos,
  }) : super(FilterTodosState(filterTodos: initialTodos)) {
    todoFilterSubscription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFilterTodos();
    });

    todoSearchSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoFilterState) {
      setFilterTodos();
    });

    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoFilterState) {
      setFilterTodos();
    });
  }

  void setFilterTodos() {
    List<Todos> _filteredtodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredtodos = todoListCubit.state.todos
            .where((Todos element) => !element.completed)
            .toList();
        break;

      case Filter.completed:
        _filteredtodos = todoListCubit.state.todos
            .where((Todos element) => element.completed)
            .toList();
        break;

      case Filter.all:
      default:
        _filteredtodos = todoListCubit.state.todos;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      _filteredtodos = todoListCubit.state.todos
          .where((Todos element) => element.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filterTodos: _filteredtodos));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}
