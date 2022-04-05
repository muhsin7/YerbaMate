import 'package:flutter/cupertino.dart';

class User {
  final int id;
  final String name;
  final String designation;
  final int age;
  final String location;
  final String bio;
  final List<String> interests;
  final String imagepath;
  bool isLiked;
  bool isDisliked;

  User({
    required this.id,
    required this.designation,
    required this.name,
    required this.age,
    required this.location,
    required this.bio,
    required this.interests,
    required this.imagepath,
    this.isLiked = false,
    this.isDisliked = false,
  });
}
