import 'package:flutter/material.dart';
import 'package:todolistapp/models/category.dart';
import 'package:todolistapp/models/task.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final VoidCallback onDelete;
   int taskcount = 0;

  CategoryGridItem({
    required this.category,
    required this.onDelete,
    required this.taskcount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category.emoji,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            category.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${taskcount} tasks",
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
