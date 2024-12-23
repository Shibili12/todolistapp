

import 'package:hive/hive.dart';
import '../models/category.dart';

class CategoryService {
  static const String categoryBoxName = 'categoryBox';

  static Future<void> initHive() async {
    Hive.registerAdapter(CategoryAdapter());
    await Hive.openBox<Category>(categoryBoxName);
  }

  static Future<void> addCategory(Category category) async {
    var box = await Hive.openBox<Category>(categoryBoxName);
    await box.add(category);
  }


  static Future<List<Category>> getCategories() async {
    var box = await Hive.openBox<Category>(categoryBoxName);
    return box.values.toList();
  }


  static Future<void> deleteCategory(int index) async {
    var box = await Hive.openBox<Category>(categoryBoxName);
    await box.deleteAt(index);
  }

  //search
  // static Future<Category?> getCategoryByName(String name) async {
  //   var box = await Hive.openBox<Category>(categoryBoxName);
  //   return box.values.firstWhere((category) => category.name == name,);
  // }
}
