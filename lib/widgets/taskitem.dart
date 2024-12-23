import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controllers/taskcontroller.dart';
import 'package:todolistapp/models/task.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  TaskListItem({required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          widget.task.isCompleted
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          color: widget.task.isCompleted ? Colors.green : Colors.grey,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            widget.task.toggleCompletion();
          });
        },
      ),
      title: Text(
        widget.task.description,
      ),
    );
  }
}
