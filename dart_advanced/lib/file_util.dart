import 'dart:io';
import 'student_score_model.dart';

List<StudentScore> loadStudentScores(String filePath) {
  List<StudentScore> scores = [];

  try {
    final file = File(filePath);
    final lines = file.readAsLinesSync();

    for (var line in lines) {
      final parts = line.split(',');

      if (parts.length != 2) throw FormatException('잘못된 데이터 형식: $line');

      String name = parts[0];
      int score = int.parse(parts[1]);

      var studentScore = StudentScore(point: score, name: name);
      scores.add(studentScore);
    }
  } catch (e) {
    print("학생 데이터를 불러오는 데 실패했습니다: $e");
    exit(1);
  }

  return scores;
}
