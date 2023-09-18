import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final Function onchecked;
  final Function ondeleted;
  final Function savetodo;
  const TodoItem({
    required this.savetodo,
    required this.onchecked,
    required this.ondeleted,
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      child: ListTile(
        // onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: IconButton(
          icon: todo.ischeck
              ? const Icon(Icons.check_box)
              : const Icon(Icons.check_box_outline_blank),
          onPressed: () {
            onchecked(todo);
            savetodo();
          },
          color: blue,
        ),
        title: Center(
          child: Text(
            todo.tdtext!,
            style: TextStyle(
              fontSize: 16,
              color: todo.ischeck ? Colors.black54 : black,
              decoration: todo.ischeck ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        trailing: Container(
          // padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: 50,
          width: 40,
          decoration: BoxDecoration(
            color: red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 15,
            icon: const Icon(Icons.delete),
            onPressed: () {
              ondeleted(todo.id);
              savetodo();
            },
          ),
        ),
      ),
    );
  }
}
