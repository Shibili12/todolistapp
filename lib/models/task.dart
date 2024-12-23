import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task {
  @HiveField(0)
  final String description;
  @HiveField(1)
  final DateTime dueDate;
  @HiveField(2)
  bool isCompleted;
  @HiveField(3)
  final String categoryId;
  @HiveField(4)
  final int id; 

  Task({
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.categoryId,
    required this.id,
  });

  void toggleCompletion() {
    
    isCompleted = !isCompleted;
  }
}
