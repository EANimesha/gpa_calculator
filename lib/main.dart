import 'package:flutter/material.dart';
import 'package:gpa/data/models/subject_model.dart';
import 'package:gpa/ui/Page.dart';
import 'package:gpa/ui/courses.dart';
import 'package:gpa/util/databaseHelper.dart';

List subjects;
int l=0;
void main() async {
  var db = new DatabaseHelper();
  var smap = [
    {"code": "SENG 11213", "desc": "fundamentals Of Computing", "credit": 3, "grade": 0.0, "year": 1},
    {"code": "SENG 11223", "desc": "Programming Concept", "credit": 3, "grade": 0.0, "year": 1},
    {"code": "SENG 11232", "desc": "Engineering Foundation", "credit": 2, "grade": 0.0, "year": 1},
    {"code": "SENG 11243", "desc": "Statistics", "credit": 3, "grade": 0.0, "year": 1},
    {"code": "PMAT 11212", "desc": "Discrete mathematics 1", "credit": 2, "grade": 0.0, "year": 1},
    {"code": "DELT 11212", "desc": "English for Professionals", "credit": 2, "grade": 0.0, "year": 1},
    {"code": "SENG 12213", "desc": "Data Structures and Algorithm", "credit": 3, "grade": 0.0, "year": 1},
    {"code": "SENG 12223", "desc": "Database Design and Development", "credit": 3, "grade": 0.0, "year": 1},
    {"code": "SENG 12233", "desc": "Object Oriented Programming", "credit": 3, "grade": 0.0, "year": 1},
    {"code": "SENG 12242", "desc": "Management for Software Engineering 1", "credit": 2, "grade": 0.0, "year": 1},
    {"code": "PMAT 12212", "desc": "Discrete mathematics 2", "credit": 2, "grade": 0.0, "year": 1},
    {"code": "DELT 12212", "desc": "Communication skills for professionals", "credit": 2, "grade": 0.0, "year": 1},

    {"code": "SENG 21213", "desc": "Computer Architecture and Operating Systems", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 21222", "desc": "Software Construction", "credit": 2, "grade": 0.0, "year": 2},
    {"code": "SENG 21233", "desc": "Requirements Engineering", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 21243", "desc": "Software Modelling", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 21253", "desc": "Web Application Development", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 21263", "desc": "Interactive Application Development", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 21272", "desc": "Management for Software Engineering 2", "credit": 2, "grade": 0.0, "year": 2},
    {"code": "SENG 22212", "desc": "Software Architecture And Design", "credit": 2, "grade": 0.0, "year": 2},
    {"code": "SENG 22223", "desc": "Human Computer Interaction", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 22233", "desc": "Software Verification and Validation", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 22243", "desc": "Mobile Application Development", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "SENG 22253", "desc": "Embedded Systems Development", "credit": 3, "grade": 0.0, "year": 2},
    {"code": "PMAT 22213", "desc": "Mathematical Methods", "credit": 3, "grade": 0.0, "year": 2},
  ];

  for (var i = 1; i<=2; i++) {
    subjects=await db.getAllSubjects(i);
    l=l+subjects.length;
  }
  if(l!=25){
    for (var i = 0; i < smap.length; i++) {
    await db.saveSubject(new Subject.map(smap[i]));
    }
  }
  // for (var i = 0; i < subjects.length; i++) {
  //   Subject subject=Subject.map(subjects[i]);
  //   print(subject.code);
  // }
  // Subject s=await db.getSubject("'SENG 11213'");
  // print(s.grade.toString());
  runApp(new MaterialApp(
    title: 'gpa',
    home: new Courses(),
  ));
}
