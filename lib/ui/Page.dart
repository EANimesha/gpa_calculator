import 'package:flutter/material.dart';
import 'package:gpa/ui/subjects_screen.dart';
import 'package:gpa/util/databaseHelper.dart';

class Page extends StatelessWidget{
  var db = new DatabaseHelper();
  int x=0;
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 4,
      child: Scaffold(
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
