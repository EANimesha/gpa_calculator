import 'package:flutter/material.dart';
import 'package:gpa/ui/createCourse.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        padding:EdgeInsets.zero,
        children:<Widget>[
          DrawerHeader(
            child: Text(
              'GPA Calculate App'
            ),
            decoration: BoxDecoration(
              color:Colors.redAccent
            ),
          ),
          ListTile(
            title:Text('Edit Contents'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCourse()),
              );
            },
          ),
          ListTile(
            title:Text('Reset All'),
          )
        ]
      )
    );
  }
  }