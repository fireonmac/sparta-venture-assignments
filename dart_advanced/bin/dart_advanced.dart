import 'package:dart_advanced/file_util.dart';

void main() {
  var scores = loadStudentScores('students.txt');
  print(scores);

  for (var score in scores) {
    print(score.name);
    print(score.point);
  }
}