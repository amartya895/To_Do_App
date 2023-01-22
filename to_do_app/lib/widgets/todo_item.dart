import 'package:flutter/material.dart';
import 'package:to_do_app/app_styles.dart/app_color.dart';
import 'package:to_do_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key, required this.todo, this.onTodoChange, this.onDeleteItem});

  final ToDo todo;
  final onTodoChange;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: styles.tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: styles.tdBlack,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: styles.tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            onPressed: () {
              onDeleteItem(todo.id);
            },
            iconSize: 20,
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
