import 'package:get/get.dart';
import 'package:todolistapp/service/taskservice.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.value = TaskService.getAllTasks();
  }

  void addTask(Task task) {
    TaskService.addTask(task).then((_) {
      tasks.add(task);
    });
  }

  List<Task> getTasksForCategory(int categoryId) {
    return tasks
        .where((task) => int.parse(task.categoryId) == categoryId)
        .toList();
  }


  // void updateTask(int taskKey, Task updatedTask) {
  //   TaskService.updateTask(taskKey, updatedTask).then((_) {
  //     int index = tasks.indexWhere((task) => task == tasks[taskKey]);
  //     if (index != -1) {
  //       tasks[index] = updatedTask;
  //       tasks.refresh();
  //     }
  //   });
  // }

  // void deleteTask(int taskKey) {
  //   TaskService.deleteTask(taskKey).then((_) {
  //     tasks.removeAt(taskKey);
  //   });
  // }


}
