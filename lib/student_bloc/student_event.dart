part of 'student_bloc.dart';

@immutable
abstract class StudentEvent extends Equatable {
  List<Object> get properties => [];
}

class AddData extends StudentEvent {
  final StudentModel studentsdata;

  AddData({required this.studentsdata});
  @override
  List<Object?> get props => [studentsdata];
}

class GetAllData extends StudentEvent {
  GetAllData();

  @override
  List<Object> get props => [];
}

class DeleteData extends StudentEvent {
  final List<StudentModel> studentModel;
  final int index;

  DeleteData({required this.studentModel, required this.index});
  @override
  List<Object?> get props => [studentModel];
}

class EditData extends StudentEvent {
  final StudentModel studentModel;
  final int index;

  EditData({required this.studentModel, required this.index});
  @override
  List<Object?> get props => [studentModel, index];
}
