import 'package:gpa/data/models/subject_model.dart';

abstract class DataSource{
  Future<int> saveSubject(Subject subject);
  Future<List>getAllSubjects();
  Future<Subject>getSubject(int id);
  Future<int> deleteSubject(int id );
  Future<int> updateSubject(Subject subject);
}