import 'package:flutter/material.dart';

class CreateCourse extends StatefulWidget {
  CreateCourse({Key key}) : super(key: key);

  @override
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final TextEditingController _codeEdittingController =new TextEditingController();
  final TextEditingController _nameEdittingController =new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Create Course')
      ),
       body: Container(
         margin: EdgeInsets.only(top:10.0),
         child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemCount: 1,
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.black26,
                  borderOnForeground: true,
                  child: new ListTile(
                    title: Text('SENG11213'),
                    subtitle: Text('Programming Concepts'),
                    trailing: new Listener(
                      // key: new Key(_itemList[index].itemName),
                      child: new Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent.shade100,
                      )
                    ),
                  ),
                );
              },
            ),
         ),
         floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.blueAccent,
          child: new ListTile(
            title: Icon(Icons.add),
          ),
          onPressed: _showFormDialog,
        ),
    );
  }





  void _showFormDialog() {
    var alert = new AlertDialog(
      content: new Column(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _codeEdittingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "course code",
                  hintText: "SENG21213",
                  icon: new Icon(Icons.note_add)),
            ),
          ),
          new Expanded(
            child: new TextField(
              controller: _nameEdittingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "course Name",
                  hintText: "Progamming concepts",
                  icon: new Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _codeEdittingController.clear();
            _nameEdittingController.clear();
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}