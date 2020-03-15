import 'dart:async';

import 'package:gpa/data/dataSources/local_data_source.dart';
import 'package:gpa/data/models/subject_model.dart';
import 'package:gpa/presentation/bloc/bloc.dart';

class SubjectsBloc implements Bloc{
  final _controller= StreamController<List>.broadcast();
  final _repository=LocalDataSource();
  Stream<List> get subjetsStream=>_controller.stream;

  getSubjects() async{
    final result=await _repository.getAllSubjects();
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

  updateSubject(Subject subject)async{
    await _repository.updateSubject(subject);
    getSubjects();
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