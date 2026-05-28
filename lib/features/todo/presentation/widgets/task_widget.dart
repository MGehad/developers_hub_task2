import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  final String task;
  final Function()? onEditPressed;
  final Function()? onDeletePressed;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: _isCompleted ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          activeColor: Colors.indigo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          value: _isCompleted,
          onChanged: (value) => setState(() => _isCompleted = value ?? false),
        ),
        title: Text(
          widget.task,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: _isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: _isCompleted ? Colors.grey : const Color(0xFF0F172A),
          ),
        ),
        subtitle: Text(
          _isCompleted ? 'Completed' : 'Tap edit to update this note',
          style: TextStyle(
            color: _isCompleted ? Colors.green : const Color(0xFF64748B),
          ),
        ),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              onPressed: widget.onEditPressed,
              icon: const Icon(Icons.edit_rounded, color: Colors.indigo),
            ),
            IconButton(
              onPressed: widget.onDeletePressed,
              icon: const Icon(Icons.delete_forever_rounded, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
