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
