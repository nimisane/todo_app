// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_todo_bloc_bloc.dart';

abstract class FilterTodoBlocEvent extends Equatable {
  const FilterTodoBlocEvent();

  @override
  List<Object> get props => [];
}

class FilteredTodoEvent extends FilterTodoBlocEvent {
  final List<Todos> filteredTodos;
  FilteredTodoEvent({
    required this.filteredTodos,
  });

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodoEvent(filteredTodos: $filteredTodos)';
}
