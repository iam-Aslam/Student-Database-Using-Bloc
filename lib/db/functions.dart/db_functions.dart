import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

//function for get

//function for add
void addStudent(StudentModel value) async {
  final StudentDB = await Hive.openBox<StudentModel>('student_db');
  final _id = await StudentDB.add(value);
  value.id = _id;
  //StudentDB.add(value);
  studentListNotifier.value.add(value);
  //rebuilding notifierlistener
  studentListNotifier.notifyListeners();
}

void getStudents() async {
  final StudentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(StudentDB.values);
  studentListNotifier.notifyListeners();
}

void deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(id);
  getStudents();
}
