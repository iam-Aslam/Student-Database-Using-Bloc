// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_na, avoid_print, camel_case_types

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student/db/functions.dart/db_functions.dart';
import 'package:student/pages/home.dart';
import 'package:student/pages/StudentProfile.dart';

import '../db/model/data_model.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  TextEditingController? searchcontroll = TextEditingController();
  searchStudent(value) {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getappbar(context: context, title: "STUDENT'S DIRECTORY"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext context, List<StudentModel> studentList,
                  Widget? child) {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      final data = studentList[index];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          tileColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.5,
                              color: Colors.orange,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: FileImage(File(data.image)),
                            maxRadius: 40,
                          ),
                          title: Text('Name: ${data.name}'),
                          subtitle: Text('Domain: ${data.domain}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline_outlined),
                            onPressed: () {
                              //Route To delete function
                              if (data.id != null) {
                                deleteStudent(data.id!);
                              } else {
                                log('Id is null');
                              }
                            },
                          ),
                          onTap: () {
                            //single view page route
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentProfile(
                                          passValue: data,
                                          passId: index,
                                        )));
                          },
                        ),
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return const Divider(
                        thickness: 0,
                      );
                    }),
                    itemCount: studentList.length);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: FloatingActionButton.extended(
          icon: Icon(Icons.add_circle_outline_sharp),
          label: Text(
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
