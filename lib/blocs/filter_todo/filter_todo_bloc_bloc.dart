// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../models/todos_model.dart';

part 'filter_todo_bloc_event.dart';
part 'filter_todo_bloc_state.dart';

class FilterTodoBlocBloc extends Bloc<FilterTodoBlocEvent, FilterTodosState> {

  final List<Todos> initialTodos;

  FilterTodoBlocBloc({
  
    required this.initialTodos,
  }) : super(FilterTodosState(filterTodos: initialTodos)) {

    on<FilteredTodoEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(filterTodos: event.filteredTodos));
    });
  }

 
 
}
