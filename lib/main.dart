import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolistapp/bindings/appbindings.dart';
import 'package:todolistapp/models/user.dart';
import 'package:todolistapp/service/category_service.dart';
import 'package:todolistapp/service/hive_service.dart';
import 'package:todolistapp/service/taskservice.dart';
import 'package:todolistapp/views/category_page.dart';
import 'package:todolistapp/views/forgot_password.dart';
import 'package:todolistapp/views/loginpage.dart';
import 'package:todolistapp/views/registerpage.dart';
import 'package:todolistapp/views/settings_page.dart';
import 'views/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await HiveService.initHive();
  await CategoryService.initHive();
  await TaskService.initHive();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      initialBinding: AppBindings(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/forgot', page: () => Forgotpage()),
        GetPage(name: '/category', page: () => CategoryPage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
      ],
    );
  }
}
