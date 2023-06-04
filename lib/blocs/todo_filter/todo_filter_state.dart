part of 'todo_filter_bloc.dart';

class TodoFilterState extends Equatable {
  TodoFilterState({required this.filter});

  final Filter filter;

  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object?> get props => [filter];

  @override
  bool get stringify => true;
  TodoFilterState copyWith({Filter? filter}) {
    return TodoFilterState(filter: filter ?? this.filter);
  }
}
