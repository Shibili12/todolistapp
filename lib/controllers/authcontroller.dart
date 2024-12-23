import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  Rxn<User> currentUser = Rxn<User>(); 
  final userBox = Hive.box<User>('userBox');
  Future<bool> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      if (userBox.isNotEmpty) {
        final existingUser = userBox.values.firstWhere(
          (user) => user.email == email,
        );

        if (existingUser.email.isNotEmpty) {
          Get.snackbar(
            'Error',
            'Email already exists!',
            snackPosition: SnackPosition.BOTTOM,
          );
          return false;
        } else {
          final newUser = User(
            fullName: fullName,
            email: email,
            password: password,
          );
          await userBox.add(newUser);
          Get.snackbar(
            'Success',
            'User registered successfully!',
            snackPosition: SnackPosition.BOTTOM,
          );
          return true;
        }
      } else {
        final newUser = User(
          fullName: fullName,
          email: email,
          password: password,
        );

        await userBox.add(newUser);

        Get.snackbar(
          'Success',
          'User registered successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      }
 
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final user = userBox.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );

      if (user == null) {
        Get.snackbar(
          'Error',
          'Invalid email or password!',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      currentUser.value = user; 
      Get.snackbar(
        'Success',
        'Logged in successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Logout a user
  void logoutUser() {
    currentUser.value = null; 
    Get.snackbar(
      'Success',
      'Logged out successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAllNamed('/login'); 
  }
}
