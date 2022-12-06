import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../db/functions.dart/db_functions.dart';
import '../../db/model/data_model.dart';

class Editprofile extends StatefulWidget {
  Editprofile({super.key, required this.index, required this.passValueProfile});
  StudentModel passValueProfile;
  int index;

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _domainController = TextEditingController();
  final _placeController = TextEditingController();

  String? file1;
  ImagePicker image = ImagePicker();

  Widget GetImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: file1 == null
              ? NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWRrWgjZtjvfCpKF-uof_08e89WR9269oYsA&usqp=CAU')
                  as ImageProvider
              : FileImage(File(file1!)),
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
                  // getgallery();
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getappbar(context: context, title: 'ADD STUDENTS'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetImage(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
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
                    decoration: InputDecoration(
                      prefixIcon: Icon(
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
                      prefixIcon: Icon(
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
                      prefixIcon: Icon(
                        Icons.place,
                        color: Colors.orange,
                      ),
                      border: OutlineInputBorder(
                        //borderSide: BorderSide(color: Colors.red),
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
                  Navigator.of(context).pushReplacementNamed('list');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(350, 55),
                  backgroundColor: Colors.orange[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10,
                ),
                icon: Icon(Icons.add),
                label: Text('UPDATE'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//add student on clicking button

// image picking UI

//function
// Future<void> takePhoto() async {
//   // ignore: non_constant_identifier_names
//   final PickedFile =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (PickedFile != null) {
//     setState(() {
//       imagePath = PickedFile.path;
//     });
//   }
// }

//appbar function......
AppBar getappbar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w800),
    ),
  );
}
