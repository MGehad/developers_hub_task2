import 'package:developers_hub_task2/core/utils/functions/show_snack_bar.dart';
import 'package:developers_hub_task2/features/todo/presentation/cubits/todo_cubit/todo_cubit.dart';
import 'package:developers_hub_task2/features/todo/presentation/widgets/todo_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  Future<void> _showTaskDialog(BuildContext context, {int? index}) async {
    final TodoCubit cubit = context.read<TodoCubit>();
    final TodoState currentState = cubit.state;
    final List<String> tasks = currentState is TodoLoaded
        ? currentState.tasks
        : [];
    final bool isEditing = index != null;
    final TextEditingController controller = TextEditingController(
      text: isEditing && index < tasks.length ? tasks[index] : '',
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(isEditing ? 'Update Note' : 'Add New Note'),
        content: TextField(
          controller: controller,
          autofocus: true,
          minLines: 1,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'Write your note here'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final String value = controller.text.trim();
              if (value.isEmpty) {
                ShowSnackBar.show(
                  context,
                  message: 'Please enter a note',
                  color: Colors.red,
                );
                return;
              }

              if (isEditing) {
                await cubit.updateTask(index: index, task: value);
              } else {
                await cubit.addTask(value);
              }

              if (!context.mounted) {
                return;
              }

              Navigator.of(dialogContext).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            child: Text(isEditing ? 'Update' : 'Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..loadTasks(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'My Notes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: false,
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TodoError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is TodoLoaded) {
                    return TodoViewBody(
                      tasks: state.tasks,
                      onAddPressed: () => _showTaskDialog(context),
                      onEditPressed: (index) =>
                          _showTaskDialog(context, index: index),
                      onDeletePressed: (index) =>
                          context.read<TodoCubit>().deleteTask(index),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showTaskDialog(context),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.note_add_rounded),
              label: const Text('New Note'),
            ),
          );
        },
      ),
    );
  }
}
