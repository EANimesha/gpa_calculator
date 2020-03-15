import 'package:flutter/material.dart';
import 'package:gpa/data/dataSources/local_data_source.dart';
import 'package:gpa/data/models/subject_model.dart';
import 'package:gpa/presentation/bloc/subjects_bloc.dart';

class Subjects extends StatefulWidget {
  int _year = 0;
  Subjects(int i) {
    this._year = i;
  }

  @override
  SubjectScreenState createState() => new SubjectScreenState(_year);
}

class SubjectScreenState extends State<Subjects> {
  final SubjectsBloc bloc = SubjectsBloc();

  int i;
  int l;
  SubjectScreenState(this.i);

  var db = new LocalDataSource();
  // List<Subject> _subjectList = <Subject>[];

  double _gpa = 0.0;
  List<String> _value;

  @override
  void initState() {
    super.initState();
    // getdata(db, i);
    bloc.getSubjects(year: i);
    gettotalGpa();
  }

  static const Map<String, String> grades = {
    '4.0': 'A+/A',
    '3.7': 'A-',
    '3.3': 'B+',
    '3.0': 'B',
    '2.7': 'B-',
    '2.3': 'C+',
    '2.0': 'C',
    '1.7': 'C-',
    '0.0': 'None',
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        body: new Column(
          children: <Widget>[
            new Flexible(
              child: StreamBuilder(
                  stream: bloc.subjetsStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.length != 0
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, int index) {
                                Subject subject = snapshot.data[index];
                                return Card(
                                  color: Colors.grey,
                                  borderOnForeground: true,
                                  child: new ListTile(
                                    title: Text(subject.code.toString()),
                                    subtitle: Text(subject.desc.toString()),
                                    
                                     trailing: new Listener(
                                          key: new Key(subject.id.toString()),
                                          child: new DropdownButton<String>(
                                            items: grades
                                                .map((value, description) {
                                                  return MapEntry(
                                                      description,
                                                      DropdownMenuItem<String>(
                                                        child: Text(description),
                                                        value: value,
                                                      ));
                                                })
                                                .values
                                                .toList(),
                                            onChanged: (String value) {
                                              subject.grade=double.parse(value);
                                              bloc.updateSubject(subject,year: i);
                                              gettotalGpa();
                                            },
                                            value: subject.grade.toString(),
                                          )
                                          ),
                                  ),
                                );
                              })
                          : Container(child: Text('Start adding subjects'));
                    } else {
                      bloc.getSubjects(year: i);
                      return Container(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    }
                  }),
            ),
            new Divider(
              height: 1.0,
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.redAccent.shade200,
          child: new Container(
              margin: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'GPA :${_gpa.toStringAsFixed(3)}',
                    style: new TextStyle(
                      fontSize: 20.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
        ));
  }

  void gettotalGpa() async {
    double gptot = 0;
    double creditCount = 0;
    List<Subject> _subjects = await db.getAllSubjects();
    for (var i = 0; i < _subjects.length; i++) {
      Subject subject = _subjects[i];
      if (subject.grade != 0.0) {
        gptot = gptot + subject.credit * subject.grade;
        creditCount = creditCount + subject.credit;
      }
    }
    setState(() {
      _gpa = gptot / creditCount;
    });
  }

//   void resetAll() async{
//     // List _subjects1 = await db.getAllSubjects(1);
//     // List _subjects2 = await db.getAllSubjects(2);
//     // for (var i = 0; i < _subjects1.length; i++) {
//     //   Subject subject = Subject.map(_subjects1[i]);
//     //   subject.grade = 0.0;
//     //   await db.updateSubject(subject);
//     // }
//     // for (var i = 0; i < _subjects2.length; i++) {
//     //   Subject subject = Subject.map(_subjects2[i]);
//     //   subject.grade = 0.0;
//     //   await db.updateSubject(subject);
//     // }
// }
}
