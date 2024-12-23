

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controllers/categorycontroller.dart';
import 'package:todolistapp/controllers/taskcontroller.dart';
import 'package:todolistapp/models/category.dart';
import 'package:todolistapp/views/task_page.dart';
import 'package:todolistapp/widgets/categorygrid.dart';
import 'package:todolistapp/widgets/quote_widget.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(223, 47, 46, 55)
          : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(223, 47, 46, 55)
            : Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/settings');
            },
            child:const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
              radius: 5,
            ),
          ),
        ),
        centerTitle: true,
        title:const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon:const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
        const  Padding(
            padding:  EdgeInsets.all(12.0),
            child: QuoteWidget(),
          ),
          Expanded(
            child: Obx(() {
        
              return GridView.builder(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: categoryController.isLoading.value
                    ? 2 
                    : categoryController.categories.length +
                        1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _showAddCategoryDialog(
                              context,
                              categoryController.categories
                                  .length); 
                        },
                        child: Container(
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
                          child:const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (categoryController.isLoading.value) {

                    return const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {

                    final category = categoryController.categories[index - 1];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => TaskPage(category: category));
                        },
                        child: CategoryGridItem(
                          category: category,
                          onDelete: () {
                            categoryController.deleteCategory(index - 1);
                          },
                          taskcount: taskController
                              .getTasksForCategory(int.parse(category.id))
                              .length,
                        ),
                      ),
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, int length) {
    final TextEditingController emojiController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController taskCountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(children: [
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Emoji input field
                TextField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  controller: emojiController,
                  decoration:const InputDecoration(
                      contentPadding: EdgeInsets.all(3),
                      isDense: true,
                      hintText: "😀",
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
                // Title input field
                TextField(
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  controller: titleController,
                  decoration:const InputDecoration(
                      contentPadding: EdgeInsets.all(3),
                      isDense: true,
                      hintText: "Title",
                      hintStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
                // Task count input field
                TextField(
                  enabled: false,
                  controller: taskCountController,
                  decoration:const InputDecoration(
                      contentPadding: EdgeInsets.all(3),
                      isDense: true,
                      hintText: "O task",
                      hintStyle: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: GestureDetector(
                    onTap: () {
                      final emoji = emojiController.text;
                      final title = titleController.text;
                       const  taskCount = 0;

           
                      categoryController.addCategory(
                        Category(
                            id: (length + 1).toString(),
                            name: title,
                            emoji: emoji,
                            taskCount: taskCount.toString()),
                      );

                      Navigator.of(context).pop();
                    },
                    child:const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 47,
            top: MediaQuery.of(context).size.height * .34,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child:const CircleAvatar(
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
}
