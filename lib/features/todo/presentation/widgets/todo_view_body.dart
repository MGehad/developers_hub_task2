import 'package:developers_hub_task2/core/services/local_database/local_database.dart';
import 'package:developers_hub_task2/features/todo/presentation/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class TodoViewBody extends StatefulWidget {
  const TodoViewBody({super.key});

  @override
  State<TodoViewBody> createState() => _TodoViewBodyState();
}

class _TodoViewBodyState extends State<TodoViewBody> {
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    _getTasks();
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          'No tasks yet, add some!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) => TaskWidget(
        key: Key(tasks[index]),
        task: tasks[index],
        onDeletePressed: () {
          LocalDatabase.deleteTask(index).then((_) => _getTasks());
        },
      ),
    );
  }

  void _getTasks() => setState(() => tasks = LocalDatabase.getTasksList());
}
