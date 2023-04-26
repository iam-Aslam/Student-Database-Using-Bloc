part of 'student_bloc.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {
  StudentInitial();
  List<Object> get properties => [];
}

class ViewAllStudents extends StudentState {
  final List<StudentModel> students;

  ViewAllStudents({required this.students});
  List<Object> get properties => [];
}
