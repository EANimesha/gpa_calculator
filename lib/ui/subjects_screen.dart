import 'package:flutter/material.dart';
import 'package:gpa/data/models/subject_model.dart';
import 'package:gpa/util/databaseHelper.dart';

class Subjects extends StatefulWidget {
  int _year = 0;
  Subjects(int i) {
    this._year = i;
  }

  @override
  SubjectScreenState createState() => new SubjectScreenState(_year);
}

class SubjectScreenState extends State<Subjects> {
  int i;
  int l;
  SubjectScreenState(this.i);
  var db = new DatabaseHelper();
  List<Subject> _subjectList = <Subject>[];
  double _gpa = 0.0;
  List<String> _value ;
  
  @override
  void initState() {
    super.initState();
    getdata(db, i);
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
    '0.0':'None',
    
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        body: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemCount: _subjectList.length,
                itemBuilder: (_, int index) {
                  String key = _subjectList[index].code;
                  return new Card(
                    color: Colors.grey,
                    child: new ListTile(
                      title: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(key),
                          new Text(
                            '${_subjectList[index].desc}',
                            style: new TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                      trailing: new Listener(
                          key: new Key(key),
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
                              _value[index] = value;
                              setValue(value, key, index);
                              _subjectList[index].grade = double.parse(value);
                              setState(() {});
                            },
                            hint: new Text('${getGrades(index)}'),
                            value: _value[index],
                          )
                          ),
                    ),
                  );
                },
              ),
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
                  new RaisedButton(
                    onPressed: resetAll,
                    child: new Text('Reset'),
                  ),
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

  void getdata(DatabaseHelper db, int y) async {
    List _subjects = await db.getAllSubjects(y);
    for (var i = 0; i < _subjects.length; i++) {
      Subject subject = Subject.map(_subjects[i]);
      setState(() {
        _subjectList.add(subject);
      });
      _value = new List<String>(_subjectList.length);
    }
  }

  String getGrades(int index) {
    var v = _subjectList[index].grade;
    if (v == 0.0) {
      return "Select";
    } else {
      return grades[v.toString()];
    }
  }

  void setValue(String value, String code, int index) async {
    var g = double.parse(value);
    Subject subjects = await db.getSubject("'$code'");
    subjects.grade = g;
    await db.updateSubject(subjects);
    gettotalGpa();
  }
  void gettotalGpa() async {
    double gptot = 0;
    double creditCount = 0;
    List _subjects1 = await db.getAllSubjects(1);
    List _subjects2 = await db.getAllSubjects(2);
    for (var i = 0; i < _subjects1.length; i++) {
      Subject subject = Subject.map(_subjects1[i]);
      if (subject.grade != 0.0) {
        gptot = gptot + subject.credit * subject.grade;
        creditCount = creditCount + subject.credit;
      }
    }
    for (var i = 0; i < _subjects2.length; i++) {
      Subject subject = Subject.map(_subjects2[i]);
      if (subject.grade != 0.0) {
        gptot = gptot + subject.credit * subject.grade;
        creditCount = creditCount + subject.credit;
      }
    }

    setState(() {
      _gpa = gptot / creditCount;
    });
  }

  void resetAll() async{
    List _subjects1 = await db.getAllSubjects(1);
    List _subjects2 = await db.getAllSubjects(2);
    for (var i = 0; i < _subjects1.length; i++) {
      Subject subject = Subject.map(_subjects1[i]);
      subject.grade = 0.0;
      await db.updateSubject(subject);
    }
    for (var i = 0; i < _subjects2.length; i++) {
      Subject subject = Subject.map(_subjects2[i]);
      subject.grade = 0.0;
      await db.updateSubject(subject);
    }
  }
}
