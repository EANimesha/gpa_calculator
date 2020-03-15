import 'dart:async';
import 'dart:ffi';

import 'package:gpa/data/dataSources/local_data_source.dart';
import 'package:gpa/data/models/subject_model.dart';
import 'package:gpa/presentation/bloc/bloc.dart';

class SubjectsBloc implements Bloc{
  final _controller= StreamController<List>.broadcast();
  final _repository=LocalDataSource();
  Stream<List> get subjetsStream=>_controller.stream;


  // setGpa(List<Subject> subjects){
  //   for (var i = 0; i < subjects.length; i++) {
  //     gpa=gpa+subjects[i].grade;
  //   }
  //   _gpaController.sink.add(gpa);
  // }

  getSubjects({int year}) async{
    final result=await _repository.getAllSubjects(year: year);
    _controller.sink.add(result);
  }


  getSubject(int id)async{
    await _repository.getSubject(id);
    getSubjects();
  }

  addSubject(Subject subject) async{
    await _repository.saveSubject(subject);
    getSubjects();
  }

  updateSubject(Subject subject,{int year})async{
    await _repository.updateSubject(subject);
    getSubjects(year: year);
  }

  deleteSuject(int id)async{
    await _repository.deleteSubject(id);
    getSubjects();
  }

  @override
  void dispose() {
    _controller.close();
  }

}