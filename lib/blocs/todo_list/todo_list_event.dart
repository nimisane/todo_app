// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoListEvent {
  final String todoDesc;
  AddTodoEvent({
    required this.todoDesc,
  });

  @override
  List<Object> get props => [todoDesc];

  @override
  String toString() => 'AddTodoEvent(todoDesc: $todoDesc)';
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String todoDesc;
  EditTodoEvent({
    required this.id,
    required this.todoDesc,
  });

  @override
  String toString() => 'EditTodoEvent(id: $id, todoDesc: $todoDesc)';

  @override
  List<Object> get props => [id, todoDesc];
}

class ToggleTodoEvent extends TodoListEvent {
  final String id;
  ToggleTodoEvent({
    required this.id,
  });

  @override
  String toString() => 'ToggleTodoEvent(id: $id)';

  @override
  List<Object> get props => [id];
}

class RemoveTodoEvent extends TodoListEvent {
  final String id;
  RemoveTodoEvent({
    required this.id,
  });

  @override
  String toString() => 'RemoveTodoEvent(id: $id)';

  @override
  List<Object> get props => [id];
}
