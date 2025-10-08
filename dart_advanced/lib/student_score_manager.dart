import 'dart:io';

import 'package:dart_advanced/file_util.dart';
import 'package:dart_advanced/student_score_model.dart';

class StudentScoreManager {
  final List<StudentScore> _scores = [];

  void load([String filePath = 'students.txt']) {
    var data = FileUtil.loadFile(filePath);
    _scores.clear();
    _scores.addAll(_parseStudentScores(data));
  }

  void save(StudentScore score, [String filePath = 'result.txt']) {
    FileUtil.saveFile(filePath, score.toString());
  }

  /// 학생 이름을 입력받아 해당 학생의 [StudentScore]를 반환합니다
  /// 데이터에 존재하는 올바른 이름을 입력할 때까지 반복하여 실행됩니다
  StudentScore promptName() {
    while (true) {
      print("어떤 학생의 통계를 확인하시겠습니까?");
      String? name = stdin.readLineSync();
      var score = findByName(name);
      if (score != null) {
        return score;
      }
    }
  }

  StudentScore? findByName(String? name) {
    try {
      return _scores.firstWhere((score) => score.name == name);
    } catch (e) {
      print('잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.');
      return null;
    }
  }

  /// '<이름>,<점수>' 형식의 문자열 데이터를 `List<StudentScore>`로 변환합니다.
  ///
  /// 입력 데이터 예시:
  /// ```
  /// 홍길동,90
  /// 김철수,80
  /// ```
  ///
  /// 입력 데이터에서 파싱된 [StudentScore] 객체들의 리스트를 반환합니다.
  ///
  /// 형식이 맞지 않는 줄이 있으면 [FormatException]을 발생시킵니다.
  List<StudentScore> _parseStudentScores(String data) {
    return data.split('\n').map((line) {
      var parts = line.split(',');
      if (parts.length != 2) {
        throw FormatException('잘못된 데이터 형식: $line');
      }
      var name = parts[0];
      var point = int.parse(parts[1]);
      return StudentScore(name: name, point: point);
    }).toList();
  }
}
