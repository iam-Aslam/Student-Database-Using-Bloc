import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/db/model/data_model.dart';
import 'package:student/pages/search.dart';

import '../student_bloc/student_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _domainController = TextEditingController();
  final _placeController = TextEditingController();
  String? file;
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // getStudents();

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: getappbar(context: context, title: 'ADD STUDENTS'),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getImage(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.text_fields,
                          color: Colors.orange,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Enter Name',
                        filled: true,
                        fillColor: Colors.brown[100],
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.orange,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Enter Age',
                        filled: true,
                        fillColor: Colors.brown[100],
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: _domainController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.text_fields,
                          color: Colors.orange,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Enter Domain',
                        filled: true,
                        fillColor: Colors.brown[100],
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: _placeController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.place,
                          color: Colors.orange,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Enter Place',
                        filled: true,
                        fillColor: Colors.brown[100],
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Addstudentbtn();
                    BlocProvider.of<StudentBloc>(context).add(
                      AddData(
                        studentsdata: StudentModel(
                          name: _nameController.text.trim(),
                          age: _ageController.text.trim(),
                          domain: _domainController.text.trim(),
                          place: _placeController.text.trim(),
                          image: file!,
                        ),
                      ),
                    );
                    Navigator.of(context).pushReplacementNamed('list');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 55),
                    backgroundColor: Colors.orange[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('ADD'),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.pushReplacementNamed(context, 'list');
          }),
          child: const Icon(Icons.list),
        ),
      ),
    );
  }

//add student on clicking button
  // Future<void> Addstudentbtn() async {
  //   final _name = _nameController.text.trim();
  //   final _age = _ageController.text.trim();
  //   final _domain = _domainController.text.trim();
  //   final _place = _placeController.text.trim();

  //   if (_name.isEmpty || _age.isEmpty || _domain.isEmpty || _place.isEmpty) {
  //     return;
  //   }
  //   //print('$_name $_age $_domain $_place');

  //   final _student = StudentModel(
  //       name: _name, age: _age, domain: _domain, place: _place, image: file!);
  //   //addStudent(_student);
  // }

  // image pick from gallery
  getgallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        file = img.path;
      });
    }
  }

  // image picking UI
  Widget getImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: file == null
              ? const NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWRrWgjZtjvfCpKF-uof_08e89WR9269oYsA&usqp=CAU')
                  as ImageProvider
              : FileImage(File(file!)),
        ),
        Positioned(
            bottom: 10,
            right: 25,
            child: InkWell(
                child: const Icon(
                  Icons.photo,
                  color: Colors.orange,
                  size: 30,
                ),
                onTap: () {
                  getgallery();
                })),
      ],
    );
  }
}

//appbar function......
AppBar getappbar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
              return const SearchScreen();
            })));
          },
          icon: const Icon(Icons.search_sharp))
    ],
    title: Text(
      title,
      style:
          const TextStyle(color: Colors.black54, fontWeight: FontWeight.w800),
    ),
  );
}
