// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todo_count_bloc_bloc.dart';

abstract class ActiveTodoCountBlocEvent extends Equatable {
  const ActiveTodoCountBlocEvent();

  @override
  List<Object> get props => [];
}

class CalculateActiveTodoCountEvent extends ActiveTodoCountBlocEvent {
  final int activeTodoCount;
  CalculateActiveTodoCountEvent({
    required this.activeTodoCount,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CalculateActiveTodoCountEvent(activeTodoCount: $activeTodoCount)';
}
