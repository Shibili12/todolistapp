import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Forgotpage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(223, 47, 46, 55)
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  "Forgot Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                )
              ],
            ),
            SizedBox(height: 20),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Enter the email address you used to create your account and we will email you a link to reset password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.toNamed('/login');
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
                child: Row(
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
