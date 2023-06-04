import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todos_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_addTodo);

    on<EditTodoEvent>(_editTodo);

    on<RemoveTodoEvent>(_removeTodo);

    on<ToggleTodoEvent>(_toggleTodo);
  }
  void _addTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    final newTodo = Todos(desc: event.todoDesc);
    final newTodos = [...state.todos, newTodo];

    emit(state.copyWith(todos: newTodos));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final List<Todos> newTodos = state.todos.map((Todos todo) {
      if (todo.id == event.id) {
        return Todos(
            id: event.id, desc: event.todoDesc, completed: todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoListState> emit) {
    final List<Todos> newTodos = state.todos.map((Todos todos) {
      if (todos.id == event.id) {
        return Todos(
            id: todos.id, desc: todos.desc, completed: !todos.completed);
      }
      return todos;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos =
        state.todos.where((Todos element) => element.id != event.id).toList();

    emit(state.copyWith(todos: newTodos));
  }
}
