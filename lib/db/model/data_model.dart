import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String domain;
  @HiveField(3)
  final String place;
  @HiveField(4)
  final String image;
  @HiveField(5)
  int? id;

  StudentModel({
    required this.name,
    required this.age,
    required this.domain,
    required this.place,
    required this.image,
    this.id,
  });
}
