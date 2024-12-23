import 'package:hive/hive.dart';
import '../models/user.dart';

class HiveService {
  static const String userBoxName = 'userBox';

  static Future<void> initHive() async {
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>(userBoxName);
  }

  static Future<void> addUser(User user) async {
    var box = Hive.box<User>(userBoxName);
    box.add(user);
  }

  static User? getUser(String username, String password, String fullname) {
    var box = Hive.box<User>(userBoxName);
    return box.values.firstWhere(
      (user) => user.email == username && user.password == password,
    );
  }
}
