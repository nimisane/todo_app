// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

enum Filter{
  all,
  active,
  completed,
}

Uuid uuid = const Uuid();

class Todos extends Equatable{
  final String id;
  final String desc;
  final bool completed;

  Todos({String? id, required this.desc, this.completed = false})
      : this.id = id ?? uuid.v4();

@override
List<Object> get props => [id, desc, completed];

  @override
  String toString() => 'Todos(id: $id, desc: $desc, completed: $completed)';
}
