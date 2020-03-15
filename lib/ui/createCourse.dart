import 'package:flutter/material.dart';
import 'package:gpa/data/models/subject_model.dart';
import 'package:gpa/presentation/bloc/subjects_bloc.dart';

class CreateCourse extends StatefulWidget {
  CreateCourse({Key key}) : super(key: key);

  @override
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final TextEditingController _codeEdittingController =new TextEditingController();
  final TextEditingController _nameEdittingController =new TextEditingController();


 final SubjectsBloc bloc=SubjectsBloc();

   @override
  void initState() {
    super.initState();
    bloc.getSubjects();
  }

 

   void _handleSubmitted(String code,String name) async {
    _codeEdittingController.clear();
    _nameEdittingController.clear();

    Subject subject =
        new Subject(code,name,int.parse(code[8]),0.0,int.parse(code[4]));
        bloc.addSubject(subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Create Course')
      ),
       body: Container(
         margin: EdgeInsets.only(top:10.0),
        child: StreamBuilder(
          stream: bloc.subjetsStream,
          builder:(BuildContext context,AsyncSnapshot<List> snapshot) {
            if(snapshot.hasData){
              return snapshot.data.length!=0
                ?ListView.builder(
              itemCount:snapshot.data.length,
              itemBuilder: (_, int index) {
                Subject subject=snapshot.data[index];
                return Card(
                  color: Colors.black26,
                  borderOnForeground: true,
                  child: new ListTile(
                    title:Text( subject.code.toString()),
                    subtitle: Text(subject.desc.toString()),
                    trailing: new Listener(
                      key: new Key(subject.code.toString()),
                      child: new Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent.shade100,
                      ),
                      onPointerDown: (pointeEvent) =>
                          _deleteSubject(subject.id, index),
                    ),
                  ),
                );
              })
              :Container(
                child:Text('Start adding subjects')
              );
            }else{
              bloc.getSubjects();
              return Container(
                child:Center(child: CircularProgressIndicator(),)
              );
            }
          }
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


  _deleteSubject(int id, int index){
    bloc.deleteSuject(id);
  }

  @override
  void dispose() {
    super.dispose();
  }

}