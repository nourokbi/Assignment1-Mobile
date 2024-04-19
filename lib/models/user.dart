import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String id;
  @HiveField(4)
  final String? imageUrl;
  @HiveField(5)
  final String? gender;


  User({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    this.imageUrl,
    this.gender,
  });
}