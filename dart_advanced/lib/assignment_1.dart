import 'dart:io';

import 'package:dart_advanced/file_util.dart';
import 'package:dart_advanced/student_score_model.dart';

void solution() {
  String studentName;
  StudentScore? studentScore; 

  print("어떤 학생의 통계를 확인하시겠습니까?");
  var scores = loadStudentScores('students.txt');
  
  do {
   studentName = promptStudentName();
   studentScore = findStudentScoreByName(studentName, scores);
  } while (studentScore == null);
}

String promptStudentName() {
  String? studentName = stdin.readLineSync();
  if (studentName == null) {
    throw ArgumentError('학생 이름을 입력해주세요.');
  }
  return studentName;
}

StudentScore? findStudentScoreByName(String name, List<StudentScore> scores) {
  try {
    return scores.where((score) => score.name == name).toList()[0];
  } catch (e) {
    print('잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.');
    return null;
  }
}
