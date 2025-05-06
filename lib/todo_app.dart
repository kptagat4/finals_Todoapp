import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<Task> tasks = [];

  void showTaskDialog({Task? task, int? index}) {
    final titleController = TextEditingController(text: task?.title ?? '');
    final descController = TextEditingController(text: task?.description ?? '');
    DateTime dueDate = task?.dueDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => dueDate = picked);
                }
              },
              child: Text("Select Due Date: ${dueDate.toLocal().toShortDateString()}"),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newTask = Task(
                title: titleController.text.trim(),
                description: descController.text.trim(),
                dueDate: dueDate,
              );
              setState(() {
                if (index != null) {
                  tasks[index] = newTask;
                } else {
                  tasks.add(newTask);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  void toggleComplete(int index) => setState(() => tasks[index].isCompleted = !tasks[index].isCompleted);
  void deleteTask(int index) => setState(() => tasks.removeAt(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asian College To-Do'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset('', height: 30), 
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Task'),
              onPressed: () => showTaskDialog(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text('No tasks yet.'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(task.description),
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (_) => toggleComplete(index),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => showTaskDialog(task: task, index: index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => deleteTask(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateFormatting on DateTime {
  String toShortDateString() => "${this.year}-${this.month}-${this.day}";
}
