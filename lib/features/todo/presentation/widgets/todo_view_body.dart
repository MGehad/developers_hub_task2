import 'package:developers_hub_task2/features/todo/presentation/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class TodoViewBody extends StatelessWidget {
  const TodoViewBody({
    super.key,
    required this.tasks,
    required this.onAddPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  final List<String> tasks;
  final VoidCallback onAddPressed;
  final ValueChanged<int> onEditPressed;
  final ValueChanged<int> onDeletePressed;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return _EmptyState(onAddPressed: onAddPressed);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeaderCard(taskCount: tasks.length, onAddPressed: onAddPressed),
        const SizedBox(height: 16),
        ...List.generate(
          tasks.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TaskWidget(
              key: ValueKey(tasks[index]),
              task: tasks[index],
              onEditPressed: () => onEditPressed(index),
              onDeletePressed: () => onDeletePressed(index),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E7FF),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.note_alt_outlined,
                size: 44,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No notes yet',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first note to start building your task list.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.taskCount, required this.onAddPressed});

  final int taskCount;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF334155)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.sticky_note_2_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$taskCount item${taskCount == 1 ? '' : 's'} saved locally',
                  style: TextStyle(color: Colors.white.withOpacity(0.78)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.tonal(
            onPressed: onAddPressed,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
