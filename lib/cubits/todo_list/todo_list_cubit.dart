import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/models/todos_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initail());

  void addTodo(String todoDesc) {
    final newTodo = Todos(desc: todoDesc);
    final newTodos = [...state.todos, newTodo];

    emit(state.copyWith(todos: newTodos));
  }

  void editTodos(String id, String desc) {
    final List<Todos> newTodos = state.todos.map((Todos todo) {
      if (todo.id == id) {
        return Todos(id: id, desc: desc, completed: todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void toggleTodos(String id) {
    final List<Todos> newTodos = state.todos.map((Todos todos) {
      if (todos.id == id) {
        return Todos(
            id: todos.id, desc: todos.desc, completed: !todos.completed);
      }
      return todos;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void removeTodos(Todos todo) {
    final newTodos =
        state.todos.where((Todos element) => element.id != todo.id).toList();

    emit(state.copyWith(todos: newTodos));
  }
}
