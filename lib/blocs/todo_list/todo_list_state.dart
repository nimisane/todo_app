// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<Todos> todos;
  TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todos(id: '1', desc: 'Clean the room'),
      Todos(id: '2', desc: 'complete project'),
      Todos(id: '3', desc: 'learn bloc'),
    ]);
  }

  @override
  String toString() => 'TodoListState(todos: $todos)';

  TodoListState copyWith({
    List<Todos>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [todos];
}
