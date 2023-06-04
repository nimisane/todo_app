part of 'active_todo_count_bloc_bloc.dart';

class ActiveTodoCountState extends Equatable {
  const ActiveTodoCountState({required this.activeTodoCount});
  final int activeTodoCount;

  factory ActiveTodoCountState.initial() {
    return const ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object?> get props => [activeTodoCount];

  @override
  String toString() {
    return 'ActiveTodoCountState{activeTodoCount=$activeTodoCount}';
  }

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}