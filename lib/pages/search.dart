import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/db/model/data_model.dart';
import 'StudentProfile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);

//widgets

  Widget listexp() {
    return Expanded(
      child: studentDisplay.isNotEmpty
          ? ListView.builder(
              itemCount: studentDisplay.length,
              itemBuilder: (context, index) {
                File img = File(studentDisplay[index].image);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(img),
                    radius: 22,
                  ),
                  title: Text(studentDisplay[index].name),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentProfile(
                                  passValue: studentDisplay[index],
                                  passId: index,
                                )));
                  }),
                );
              },
            )
          : const Center(
              child: Text(
                'No match found',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget searchTextField() {
    return TextFormField(
      autofocus: true,
      controller: _searchController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => clearText(),
        ),
        filled: true,
        fillColor: const Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: 'search',
      ),
      onChanged: (value) {
        _searchStudent(value);
      },
    );
  }

  void _searchStudent(String value) {
    setState(() {
      studentDisplay = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearText() {
    _searchController.clear();
  }

  //builder-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              searchTextField(),
              listexp(),
            ],
          ),
        ),
      ),
    );
  }
}
