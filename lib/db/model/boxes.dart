import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/db/model/data_model.dart';

class StudentBox {
  static Box<StudentModel> getstudentData() =>
      Hive.box<StudentModel>('student_db');
}
