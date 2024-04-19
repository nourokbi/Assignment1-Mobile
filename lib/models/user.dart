import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String studentId;
  @HiveField(4)
  String imageUrl;
  @HiveField(5)
  String gender;
  @HiveField(6)
  int level;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.studentId,
    this.imageUrl = '',
    this.gender = '',
    this.level = 0,
  });
}
