// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

//function for add
Future<void> addStudent(StudentModel value) async {
  try {
    var StudentDB = await Hive.openBox<StudentModel>('student_db');
    final _id = await StudentDB.add(value);
    value.id = _id;
    studentListNotifier.value.add(value);
    //rebuilding notifierlistener=======
    studentListNotifier.notifyListeners();
  } catch (e) {
    log(e.toString());
  }
}

//function for getdetails from hive and reading through Notifier========
Future<void> getStudents() async {
  try {
    var StudentDB = await Hive.openBox<StudentModel>('student_db');
    studentListNotifier.value.clear();
    studentListNotifier.value.addAll(StudentDB.values);
    studentListNotifier.notifyListeners();
  } catch (e) {
    log(e.toString());
  }
}

Future<void> deleteStudent(int id) async {
  try {
    var studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    getStudents();
  } catch (e) {
    log(e.toString());
  }
}
