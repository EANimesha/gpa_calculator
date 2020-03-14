import 'package:flutter/material.dart';
import 'package:gpa/data/dataSources/local_data_source.dart';
import 'package:gpa/data/models/subject_model.dart';

class CreateCourse extends StatefulWidget {
  CreateCourse({Key key}) : super(key: key);

  @override
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final TextEditingController _codeEdittingController =new TextEditingController();
  final TextEditingController _nameEdittingController =new TextEditingController();

  var db = new LocalDataSource();
  final List<Subject> _itemList = <Subject>[];

   @override
  void initState() {
    super.initState();
    _readSubjectsList();
  }

   void _handleSubmitted(String code,String name) async {
    _codeEdittingController.clear();
    _nameEdittingController.clear();

    Subject subject =
        new Subject(code,name,int.parse(code[8]),0.0,int.parse(code[4]));
    int savedSubjectId = await db.saveSubject(subject);

    Subject adddedItem = await db.getSubject(savedSubjectId);

    setState(() {
      _itemList.insert(0, adddedItem);
    });
    // print(savedItemId);
  }

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
              itemCount:_itemList.length,
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.black26,
                  borderOnForeground: true,
                  child: new ListTile(
                    title:Text( _itemList[index].code),
                    subtitle: Text(_itemList[index].desc),
                    trailing: new Listener(
                      key: new Key(_itemList[index].code),
                      child: new Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent.shade100,
                      ),
                      onPointerDown: (pointeEvent) =>
                          _deleteSubject(_itemList[index].id, index),
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
            _handleSubmitted(_codeEdittingController.text,_nameEdittingController.text);
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

  _readSubjectsList() async {
    List items = await db.getAllSubjects();
    items.forEach((item) {
      // NoToDoItem noToDoItem=NoToDoItem.map(item);
      setState(() {
        _itemList.add(Subject.map(item));
      });
      // print(noToDoItem.itemName);
    });
  }

  _deleteSubject(int id, int index) async {
    await db.deleteSubject(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

}