import 'package:developers_hub_task2/core/services/local_database/local_database.dart';
import 'package:developers_hub_task2/core/utils/functions/show_snack_bar.dart';
import 'package:developers_hub_task2/features/todo/presentation/widgets/todo_view_body.dart';
import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Add New Task'),
                content: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter todo task',
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      LocalDatabase.addTask(value).then((_) {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                        setState(() {});
                      });
                    } else {
                      ShowSnackBar.show(
                        context,
                        message: 'Please enter a task',
                        color: Colors.red,
                      );
                    }
                  },
                ),
              ),
            ),
            icon: Icon(Icons.add),
            color: Colors.indigo,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(child: TodoViewBody()),
    );
  }
}
