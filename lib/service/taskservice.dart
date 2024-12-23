import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskService {
  static const String taskBoxName = 'taskBox';


  static Future<void> initHive() async {
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>(taskBoxName);
  }


  static Future<void> addTask(Task task) async {
    var box = Hive.box<Task>(taskBoxName);
    await box.add(task);
  }


  static List<Task> getAllTasks() {
    var box = Hive.box<Task>(taskBoxName);
    return box.values.toList();
  }


  static List<Task> getTasksForCategory(int categoryId) {
    var box = Hive.box<Task>(taskBoxName);
    return box.values.where((task) => task.categoryId == categoryId).toList();
  }

  // static Future<void> updateTask(int taskId, Task task) async {
  //   var box = await Hive.openBox<Task>(taskBoxName);
  //   int index = box.values.toList().indexWhere((t) => t.id == taskId);
  //   if (index != -1) {
  //     await box.putAt(index, task); 
  //   }
  // }

 
  // static Future<void> deleteTask(int taskKey) async {
  //   var box = Hive.box<Task>(taskBoxName);
  //   await box.delete(taskKey);
  // }
}
