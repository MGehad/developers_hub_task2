import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.onDeletePressed,
  });

  final String task;
  final Function()? onDeletePressed;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        activeColor: Colors.indigo,
        value: _isCompleted,
        onChanged: (value) => setState(() => _isCompleted = value ?? false),
      ),
      title: Text(
        widget.task,
        style: _isCompleted
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              )
            : null,
      ),
      trailing: IconButton(
        onPressed: widget.onDeletePressed,
        icon: Icon(Icons.delete_forever, color: Colors.red),
      ),
    );
  }
}
