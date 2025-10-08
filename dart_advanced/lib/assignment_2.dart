import 'package:dart_advanced/file_util.dart';
import 'package:dart_advanced/student_util.dart';

void solution() {
  var data = FileUtil.loadFile('students.txt');
  var scores = parseStudentScoresData(data);
  var score = promptStudentScore(scores);
  FileUtil.saveFile('result.txt', '이름: ${score.name}, 점수: ${score.point}');
}