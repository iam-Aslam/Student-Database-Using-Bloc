// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/db/model/data_model.dart';
import 'package:student/pages/home.dart';
import '../student_bloc/student_bloc.dart';
import 'StudentProfile.dart';

class List extends StatelessWidget {
  List({super.key});

  TextEditingController? searchcontroll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getappbar(context: context, title: "STUDENT'S DIRECTORY"),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state is StudentInitial) {
                  context.read<StudentBloc>().add(GetAllData());
                }
                if (state is ViewAllStudents) {
                  if (state.students.isNotEmpty) {
                    return ListView.separated(
                        itemBuilder: ((context, index) {
                          //  final data = studentList[index];

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              tileColor: Colors.white54,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1.5,
                                  color: Colors.orange,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    File(state.students[index].image)),
                                maxRadius: 40,
                              ),
                              title:
                                  Text('Name: ${state.students[index].name}'),
                              subtitle: Text(
                                  'Domain: ${state.students[index].domain}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline_outlined),
                                onPressed: () {
                                  context.read<StudentBloc>().add(
                                        DeleteData(
                                            studentModel: state.students,
                                            index: index),
                                      );
                                },
                              ),
                              onTap: () {
                                // single view page route
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentProfile(
                                      passValue: StudentModel(
                                        name: state.students[index].name,
                                        age: state.students[index].age,
                                        domain: state.students[index].domain,
                                        place: state.students[index].place,
                                        image: state.students[index].image,
                                      ),
                                      passId: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return const Divider(
                            thickness: 0,
                          );
                        }),
                        itemCount: state.students.length);
                  }
                }
                return const Center(
                  child: Text('List is empty'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add_circle_outline_sharp),
          label: const Text(
            "ADD NEW",
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('home');
          },
        ),
      ),
    ));
  }
}
