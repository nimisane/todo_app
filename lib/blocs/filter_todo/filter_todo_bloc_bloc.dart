// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:to_do_app/blocs/blocs.dart';

import '../../models/todos_model.dart';

part 'filter_todo_bloc_event.dart';
part 'filter_todo_bloc_state.dart';

class FilterTodoBlocBloc extends Bloc<FilterTodoBlocEvent, FilterTodosState> {
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoListBloc todoListBloc;

  final List<Todos> initialTodos;

  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoListSubscription;

  FilterTodoBlocBloc({
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.todoListBloc,
    required this.initialTodos,
  }) : super(FilterTodosState(filterTodos: initialTodos)) {
    todoFilterSubscription = todoFilterBloc.stream.listen(
      (TodoFilterState todoFilterState) {
        setFilterTodos();
      },
    );

    todoSearchSubscription =
        todoSearchBloc.stream.listen((TodoSearchState todoFilterState) {
      setFilterTodos();
    });

    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoFilterState) {
      setFilterTodos();
    });

    on<FilteredTodoEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(filterTodos: event.filteredTodos));
    });
  }

  void setFilterTodos() {
    List<Todos> _filteredtodos;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredtodos = todoListBloc.state.todos
            .where((Todos element) => !element.completed)
            .toList();

        break;

      case Filter.completed:
        _filteredtodos = todoListBloc.state.todos
            .where((Todos element) => element.completed)
            .toList();

        break;

      case Filter.all:
      default:
        _filteredtodos = todoListBloc.state.todos;

        break;
    }

    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      _filteredtodos = _filteredtodos
          .where((Todos Todos) => Todos.desc
              .toLowerCase()
              .contains(todoSearchBloc.state.searchTerm.toLowerCase()))
          .toList();
    }

    add(FilteredTodoEvent(filteredTodos: _filteredtodos));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}
