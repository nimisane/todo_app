import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo_list/todo_list_bloc.dart';

part 'active_todo_count_bloc_event.dart';
part 'active_todo_count_bloc_state.dart';

class ActiveTodoCountBlocBloc
    extends Bloc<ActiveTodoCountBlocEvent, ActiveTodoCountState> {
  final int initialActiveTodoCount;

  late final StreamSubscription todoListSubscription;
  final TodoListBloc todoListBloc;

  ActiveTodoCountBlocBloc(
      {required this.initialActiveTodoCount, required this.todoListBloc})
      : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      final int currentactiveTodoCount = todoListState.todos
          .where((element) => !element.completed)
          .toList()
          .length;

      add(CalculateActiveTodoCountEvent(
          activeTodoCount: currentactiveTodoCount));
    });

    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
