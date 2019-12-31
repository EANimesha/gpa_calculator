import 'package:flutter/widgets.dart';

class Subject extends StatelessWidget{
  String _code;
  String _desc;
  double _grade;
  int _credit;
  int _id;
  int _year;

  Subject(this._code,this._desc,this._credit,this._grade,this._year);

  Subject.map(dynamic obj){
    this._code=obj["code"];
    this._desc=obj["desc"];
    this._grade=obj["grade"];
    this._credit=obj["credit"];
    this._year=obj["year"];
    this._id=obj["id"];
  }

  String get code=>_code;
  String get desc=>_desc;
  double get grade=>_grade;
  int get credit=>_credit;
  int get year=>_year;
  int get id=>_id;

  set grade(double g)=>this._grade=g;

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
    map["code"]=_code;
    map["desc"]=_desc;
    map["grade"]=_grade;
    map["credit"]=_credit;
    map["year"]=_year;

    if(id!=null){
      map["id"]=_id;
    }
    return map;
  }

  Subject.fromMap(Map<String,dynamic> map){
    this._code=map["code"];
    this._desc=map["desc"];
    this._grade=map["grade"];
    this._credit=map["credit"];
    this._year=map["year"];
    this._id=map["id"];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_code),
          new Container(
            child: Text(_desc),
          )
        ],
      ),
    );
  }

}