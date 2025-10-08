import 'dart:io';
import 'package:dart_advanced/student_score_model.dart';

List<StudentScore> parseStudentScoresData(String data) {
  List<StudentScore> scores = [];
  final lines = data.split('\n');
  for (var line in lines) {
    var parts = line.split(',');
    if (parts.length != 2) {
      throw FormatException('잘못된 데이터 형식: $line');
    }
    String name = parts[0];
    int point = int.parse(parts[1]);
    var score = StudentScore(name: name, point: point);
    scores.add(score);
  }
  return scores;
}

StudentScore promptStudentScore(List<StudentScore> scores) {
  String studentName;
  StudentScore? studentScore;

  do {
    studentName = _promptStudentName();
    studentScore = _findStudentScoreByName(studentName, scores);
  } while (studentScore == null);

  return studentScore;
}

String _promptStudentName() {
  print("어떤 학생의 통계를 확인하시겠습니까?");
  String? studentName = stdin.readLineSync();
  if (studentName == null) {
    throw ArgumentError('학생 이름을 입력해주세요.');
  }
  return studentName;
}

StudentScore? _findStudentScoreByName(String name, List<StudentScore> scores) {
  try {
    var score = scores.where((score) => score.name == name).toList()[0];
    print('이름: ${score.name}, 점수: ${score.point}');
    return score;
  } catch (e) {
    print('잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.');
    return null;
  }  
}
