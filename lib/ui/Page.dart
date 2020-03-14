import 'package:flutter/material.dart';
import 'package:gpa/ui/createCourse.dart';
import 'package:gpa/ui/menuWidget.dart';
import 'package:gpa/ui/subjects_screen.dart';

class Page extends StatefulWidget{
  static final String id='page';
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {

  int x=0;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer:MyMenu().build(context) ,
        appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Year 1'),
                Tab(text: 'Year 2'),
                Tab(text: 'Year 3'),
                Tab(text: 'Year 4'),
              ],
            ),
            title: Text('SE GPA CALCULATOR'),
            centerTitle: true,
            backgroundColor: Colors.redAccent.shade200,
          ),
          body: TabBarView(
            children: [
              new Subjects(1),
              new Subjects(2),
              new Subjects(3),
              new Subjects(4)
            ],
        ),
        
      ),
    );
  }
}
