import 'package:dart_advanced/student_score_manager.dart';

void solution() {
  var manager = StudentScoreManager();
  manager.load();
  var score = manager.promptName();
  score.showInfo();
  manager.save(score);
}
