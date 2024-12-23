import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todolistapp/controllers/authcontroller.dart';
import '../models/user.dart';
// Import the AuthController

class RegisterPage extends StatelessWidget {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Fetch the AuthController instance
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(223, 47, 46, 55)
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.offNamed('/login');
                    },
                    icon: Icon(Icons.arrow_back)),
                SizedBox(
                  width: 60,
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildTextField(fullNameController, 'Full name'),
            SizedBox(height: 10),
            _buildTextField(emailController, 'Email'),
            SizedBox(height: 10),
            _buildTextField(passwordController, 'Password'),
            SizedBox(height: 10),
            _buildTextField(confirmPasswordController, 'Confirm Password'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                if (_validateInputs()) {
                  final newUser = User(
                    fullName: fullNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  bool success = await authController.registerUser(
                    fullName: fullNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (success) {
                    Get.offNamed('/login');
                  }
                }
              },
              child: _buildButton('CONTINUE'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: GestureDetector(
                onTap: () => Get.toNamed('/login'),
                child: Row(
                  children: [
                    Text("Already have an account?"),
                    Text(
                      ' Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.indigo[400],
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
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }
}
