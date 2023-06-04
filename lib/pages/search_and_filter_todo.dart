import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/blocs.dart';
import 'package:to_do_app/utils/debounce.dart';

import '../models/todos_model.dart';

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({super.key});

  final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: "search todo...",
              border: InputBorder.none,
              filled: true,
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (String value) {
              if (value.trim().isNotEmpty) {
                debounce.run(() {
                  context.read<TodoSearchBloc>().add(SetSearchTermEvent(newSearchTerm: value));
                });
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              filterButton(context, Filter.all),
              filterButton(context, Filter.active),
              filterButton(context, Filter.completed),
            ],
          ),
        ],
      ),
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return InkWell(
        onTap: () {
          context.read<TodoFilterBloc>().add(ChangeFilterEvent(newFilter: filter));
        },
        child: Text(
          filter == Filter.all
              ? "All"
              : filter == Filter.active
                  ? "Active"
                  : "Completed",
          style: TextStyle(fontSize: 18, color: textColor(context, filter)),
        ));
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentilter = context.watch<TodoFilterBloc>().state.filter;

    return currentilter == filter ? Colors.blue : Colors.grey;
  }
}
