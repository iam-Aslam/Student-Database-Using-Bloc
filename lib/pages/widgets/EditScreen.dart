// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/pages/home.dart';
import '../../db/functions.dart/db_functions.dart';
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

  Future<void> StudentAddBtn(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _place = _placeController.text.trim();
    final _domain = _domainController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _domain.isEmpty || _place.isEmpty) {
      return;
    }
    final _students = StudentModel(
      name: _name,
      age: _age,
      domain: _domain,
      place: _place,
      image: imagePath!,
    );
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, _students);
    getStudents();
  }

  Future<void> takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        StudentAddBtn(widget.index);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const list()),
            (route) => false);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(350, 55),
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
              dpImage(),
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
              elavatedbtn(),
            ]),
          ),
        ));
  }
}
