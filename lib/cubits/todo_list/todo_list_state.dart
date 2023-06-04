// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  final List<Todos> todos;
  TodoListState({required this.todos});

  factory TodoListState.initail() {
    return TodoListState(todos: [
      Todos(id: '1',desc: 'Clean the room'),
      Todos(id: '2',desc: 'complete project'),
      Todos(id: '3',desc: 'learn bloc'),
    ]);
  }

  @override
  List<Object?> get props => [todos];

  @override
  String toString() {
    return 'TodoListState{todos=$todos}';
  }

  TodoListState copyWith({List<Todos>? todos}) {
    return TodoListState(todos: todos ?? this.todos);
  }
}
