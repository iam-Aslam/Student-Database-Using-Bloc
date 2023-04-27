// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/pages/home.dart';
import 'package:student/student_bloc/student_bloc.dart';
import '../../db/model/data_model.dart';
import '../list.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.index, required this.passValueProfile})
      : super(key: key);

  StudentModel passValueProfile;
  int index;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _domainController = TextEditingController();
  final _placeController = TextEditingController();
  String? imagePath;

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        // StudentAddBtn(widget.index);
        // final student=StudentModel()
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => List()), (route) => false);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(350, 55),
        backgroundColor: Colors.orange[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
      ),
      icon: const Icon(Icons.upgrade),
      label: const Text('Update'),
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, required String hintName}) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.brown[100],
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        hintText: hintName,
      ),
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: imagePath == null
              ? FileImage(File(widget.passValueProfile.image))
              : FileImage(File(imagePath!)),
        ),
        Positioned(
            bottom: 2,
            right: 10,
            child: InkWell(
                child: const Icon(
                  Icons.photo,
                  size: 30,
                ),
                onTap: () {
                  takePhoto();
                })),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getappbar(context: context, title: 'EDIT'),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              // dpImage(),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: imagePath == null
                        ? FileImage(File(widget.passValueProfile.image))
                        : FileImage(File(imagePath!)),
                  ),
                  Positioned(
                      bottom: 2,
                      right: 10,
                      child: InkWell(
                          child: const Icon(
                            Icons.photo,
                            size: 30,
                          ),
                          onTap: () {
                            takePhoto();
                          })),
                ],
              ),
              szdBox,
              textFieldName(
                  myController: _nameController,
                  hintName: widget.passValueProfile.name),
              szdBox,
              textFieldName(
                  myController: _ageController,
                  hintName: widget.passValueProfile.age),
              szdBox,
              textFieldName(
                  myController: _domainController,
                  hintName: widget.passValueProfile.domain),
              szdBox,
              textFieldName(
                  myController: _placeController,
                  hintName: widget.passValueProfile.place),
              szdBox,
              // elavatedbtn(),
              ElevatedButton.icon(
                onPressed: () {
                  // StudentAddBtn(widget.index);
                  final student = StudentModel(
                    name: _nameController.text,
                    age: _ageController.text,
                    domain: _domainController.text,
                    place: _placeController.text,
                    image: imagePath.toString(),
                  );
                  context.read<StudentBloc>().add(
                        EditData(
                          studentModel: student,
                          index: widget.index,
                        ),
                      );
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => List()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 55),
                  backgroundColor: Colors.orange[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10,
                ),
                icon: const Icon(Icons.upgrade),
                label: const Text('Update'),
              ),
            ]),
          ),
        ));
  }
}
