part of 'filter_todo_bloc_bloc.dart';

class FilterTodosState extends Equatable {
  FilterTodosState({required this.filterTodos});
  final List<Todos> filterTodos;

  factory FilterTodosState.initial() {
    return FilterTodosState(filterTodos: []);
  }

  @override
  String toString() {
    return 'FilterTodosState{filterTodos=$filterTodos}';
  }

  @override
  List<Object?> get props => [filterTodos];

  FilterTodosState copyWith({
    List<Todos>? filterTodos,
  }) {
    return FilterTodosState(
      filterTodos: filterTodos ?? this.filterTodos,
    );
  }
}