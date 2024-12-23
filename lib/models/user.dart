import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  User({
    required this.fullName,
    required this.email,
    required this.password,
  });
}
