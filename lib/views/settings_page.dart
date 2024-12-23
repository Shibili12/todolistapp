import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controllers/authcontroller.dart';
import 'package:todolistapp/widgets/profilewidget.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  AuthController authController = Get.put(AuthController());
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Profilewidget(fullname: authController.currentUser.value!.fullName),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text("Genaral"),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text("Account"),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text("Logout"),
            onTap: () {
              authController.logoutUser();
            },
          ),
        ],
      ),
    );
  }
}
