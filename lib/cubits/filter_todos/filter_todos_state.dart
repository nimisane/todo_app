// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_todos_cubit.dart';

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
