import 'dart:async';
import 'dart:io';

import 'package:gpa/model/subject.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance =new DatabaseHelper.internal();
  
  factory DatabaseHelper()=>_instance;

  final String tableSubject="subjectTable";
  final String columnId="id";
  final String columnCode="code";
  final String columnDesc="desc";
  final String columnGrade="grade";
  final String columnCredit="credit";
  final String columnYear="year";

  static Database _db;

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    _db =await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory=await getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path,"gpalasss.db");

    var ourDb=await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
      "CREATE TABLE $tableSubject($columnId INTEGER PRIMARY KEY,$columnCode TEXT,$columnDesc TEXT,$columnCredit INTEGER,$columnGrade DOUBLE,$columnYear INTEGER);"
      );
  }

//insert
  Future<int> saveSubject (Subject subject) async{
    var dbClient=await db;
    int res=await dbClient.insert("$tableSubject", subject.toMap());
    return res;
  }

  //get Users

  Future<List> getAllSubjects(int y)async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT * FROM $tableSubject WHERE $columnYear=$y");
    return result.toList();
  }
  Future<int> getCount() async{
    var dbClient=await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableSubject")
    );
  }

  Future<Subject> getSubject(String scode) async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT * FROM $tableSubject WHERE $columnCode=$scode");
    if(result.length==0){
      return null;
    }
    return new Subject.fromMap(result.first);
  }

  // //delete
  // Future<int> deleteUser(int id ) async{
  //   var dbClient=await db;
  //   return await dbClient.delete(tableSubject,where:"$columnId=?",whereArgs: [id]);

  // }

  //update
  Future<int> updateSubject(Subject subject) async{
    var dbClient=await db;
    return await dbClient.update(tableSubject,subject.toMap(),where:"$columnCode=?",whereArgs: [subject.code]);
  }

  Future close() async{
    var dbClient=await db;
    return dbClient.close();
  }
}