import 'package:get/get.dart';
import 'package:todolistapp/service/category_service.dart';
import '../models/category.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      var fetchedCategories = await CategoryService.getCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addCategory(Category category) async {
    await CategoryService.addCategory(category);
    fetchCategories();
  }

  Future<void> deleteCategory(int index) async {
    await CategoryService.deleteCategory(index);
    fetchCategories();
  }
}
