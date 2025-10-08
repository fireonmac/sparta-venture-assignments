import 'dart:io';

import 'package:dart_advanced/file_util.dart';
import 'package:dart_advanced/student_score_model.dart';
import 'package:dart_advanced/student_util.dart';

void solution() {
  var data = loadFile('students.txt');
  var scores = parseStudentScoresData(data);

  void promptMenu() {
    print('''
메뉴를 선택하세요:
1. 우수생 출력
2. 전체 평균 점수 출력
3. 종료
''');

    var selectedNumber = int.parse(stdin.readLineSync() ?? '0');
    switch (selectedNumber) {
      case 1:
        var score = getTopScore(scores);
        print('우수생: ${score.name} (평균 점수: ${score.point})');
        promptMenu();
        return;
      case 2:
        var scorePointMean =
            scores.fold(0, (acc, score) => acc += score.point) / scores.length;
        print('전체 평균 점수: $scorePointMean');
        promptMenu();
        return;
      default:
        print('프로그램을 종료합니다.');
        return;
    }
  }

  promptMenu();
}

StudentScore getTopScore(List<StudentScore> scores) {
  StudentScore score = scores[0];

  for (var sc in scores) {
    if (sc.point > score.point) {
      score = sc;
    }
  }

  return score;
}
