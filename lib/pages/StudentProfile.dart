// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student/db/model/data_model.dart';
import 'package:student/pages/widgets/EditScreen.dart';
import 'home.dart';

class StudentProfile extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 160;

  StudentProfile({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  StudentModel passValue;
  final int passId;

  //functions and widgets

  Widget top() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(clipBehavior: Clip.none, children: [
      Container(margin: EdgeInsets.only(bottom: bottom), child: CoverImage()),
      Positioned(
        top: top,
        left: 100,
        child: ProfileImage(),
      ),
    ]);
  }

  Widget data() {
    return Container(
      width: 200,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' ${passValue.name}',
            style: const TextStyle(fontSize: 28, fontFamily: 'Ubuntu'),
          ),
          Text('Age : ${passValue.age}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Domain : ${passValue.domain}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Place : ${passValue.place}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CoverImage() => Container(
        color: const Color.fromRGBO(234, 236, 238, 2),
        width: double.infinity,
        height: coverHeight,
      );

  // ignore: non_constant_identifier_names
  Widget ProfileImage() => CircleAvatar(
        backgroundImage: FileImage(File(passValue.image)),
        radius: profileHeight / 2,
      );

  Widget floatbtn(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfile(
                        passValueProfile: passValue,
                        index: passId,
                      )));
        },
        child: const Icon(Icons.edit_outlined));
  }

  //builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatbtn(context),
        appBar: getappbar(context: context, title: 'PROFILE'),
        body: ListView(children: <Widget>[
          top(),
          data(),
        ]));
  }
}
