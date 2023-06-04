// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:to_do_app/models/todos_model.dart';

part 'filter_todos_state.dart';

class FilterTodosCubit extends Cubit<FilterTodosState> {
 
  final List<Todos> initialTodos;

  FilterTodosCubit({

    required this.initialTodos,
  }) : super(FilterTodosState(filterTodos: initialTodos));

  void setFilterTodos(Filter filter, List<Todos> todos, String searchTerm) {
    List<Todos> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todos Todos) => !Todos.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos = todos.where((Todos Todos) => Todos.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todos Todos) =>
              Todos.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    emit(state.copyWith(filterTodos: _filteredTodos));
  }
}
