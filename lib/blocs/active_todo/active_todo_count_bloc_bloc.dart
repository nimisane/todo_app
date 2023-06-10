import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'active_todo_count_bloc_event.dart';
part 'active_todo_count_bloc_state.dart';

class ActiveTodoCountBlocBloc
    extends Bloc<ActiveTodoCountBlocEvent, ActiveTodoCountState> {
  final int initialActiveTodoCount;

  ActiveTodoCountBlocBloc(
      {required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {

    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }

}
