import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controllers/authcontroller.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(223, 47, 46, 55)
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? "assets/images/mimodark.jpg" 
                  : "assets/images/IMG_7655.jpg", 
            ),
            Container(
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
                controller: usernameController,
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Container(
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
                controller: passwordController,
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/forgot');
                  },
                  child: Text(
                    ' Forgot password ?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final res = await authController.loginUser(
                  email: usernameController.text,
                  password: passwordController.text,
                );
                if (res) {
                  Get.toNamed('/category');
                }
              },
              child: Container(
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
                  'CONTINUE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: GestureDetector(
                onTap: () => Get.toNamed('/register'),
                child:const Row(
                  children: [
                    Text("Don't have an account?"),
                    Text(
                      ' Register',
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
}
