import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:student/db/model/boxes.dart';
import 'package:student/db/model/data_model.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<GetAllData>((event, emit) {
      final studentData = StudentBox.getstudentData();
      List<StudentModel> studentslist = studentData.values.toList();
      emit(ViewAllStudents(students: studentslist));
    });
    on<AddData>((event, emit) {
      final studentBox = StudentBox.getstudentData();
      studentBox.add(event.studentsdata);
      add(GetAllData());
    });
  }
}
