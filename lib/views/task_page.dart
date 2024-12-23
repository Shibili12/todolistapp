import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controllers/taskcontroller.dart';
import 'package:todolistapp/models/category.dart';
import 'package:todolistapp/widgets/taskitem.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatelessWidget {
  final Category category;
  final TaskController taskController = Get.put(TaskController());

  TaskPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(223, 47, 46, 55)
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          category.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(223, 47, 46, 55)
            : Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: GestureDetector(
            onTap: () => Get.toNamed('/category'),
            child: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Get tasks for the specific category
        final tasksForCategory =
            taskController.getTasksForCategory(int.parse(category.id));

        if (tasksForCategory.isEmpty) {
          return const Center(child: Text('No tasks available.'));
        }

        // Group tasks by due date
        final Map<String, List<Task>> groupedTasks =
            _groupTasksByDate(tasksForCategory);

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: groupedTasks.length,
          itemBuilder: (context, index) {
            final dateKey = groupedTasks.keys.toList()[index];
            final tasks = groupedTasks[dateKey]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateKey,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(height: 8),
                ...tasks.map((task) => TaskListItem(task: task)).toList(),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _showAddTaskDialog(
          context,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(3),
                      isDense: true,
                      hintText: "Type Your Task ...",
                      hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: IconButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (pickedDate != null) {
                              selectedDate = pickedDate;
                            }
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ))),
                ),
                IconButton(
                  onPressed: () {
                    if (descriptionController.text.isNotEmpty &&
                        selectedDate != null) {
                      final newTask = Task(
                          description: descriptionController.text,
                          dueDate: selectedDate!,
                          categoryId: category.id,
                          id: taskController
                                  .getTasksForCategory(int.parse(category.id))
                                  .length +
                              1);
                      taskController.addTask(newTask);
                      Navigator.pop(context);
                    } else {
                      Get.snackbar(
                        'Error',
                        'Select date!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 43,
            top: MediaQuery.of(context).size.height * .36,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.white,
                  )),
            ),
          ),
        ]);
      },
    );
  }

  Map<String, List<Task>> _groupTasksByDate(List<Task> tasks) {
    final Map<String, List<Task>> groupedTasks = {};
    final now = DateTime.now();

    for (var task in tasks) {
      String key;

      if (task.dueDate.day == now.day &&
          task.dueDate.month == now.month &&
          task.dueDate.year == now.year) {
        key = 'Today';
      } else if (task.dueDate.day == now.add(const Duration(days: 1)).day &&
          task.dueDate.month == now.month &&
          task.dueDate.year == now.year) {
        key = 'Tomorrow';
      } else {
        key = DateFormat('EEE, MMM dd, yyyy').format(task.dueDate);
      }

      if (!groupedTasks.containsKey(key)) {
        groupedTasks[key] = [];
      }
      groupedTasks[key]!.add(task);
    }

    return groupedTasks;
  }
}
