import 'dart:io';
import 'package:dart_advanced/file_util.dart';
import 'package:dart_advanced/student_score_model.dart';

class StudentScoreManager {
  final List<StudentScore> _scores = [];

  List<StudentScore> getAllScores() => List.unmodifiable(_scores);

  StudentScore getTopScore() {
    return _scores.reduce(
      (current, next) => current.point > next.point ? current : next,
    );
  }

  double getAverageScore() {
    var total = _scores.fold<int>(0, (sum, score) => sum + score.point);
    return total / _scores.length;
  }

  /// 학생 정보가 기록된 파일을 불러와서 `List<StudentScore>` 형태로 [_scores]에 저장합니다
  /// 기존 데이터가 있는 경우 삭제합니다
  void load([String filePath = 'students.txt']) {
    var data = FileUtil.loadFile(filePath);
    _scores.clear();
    _scores.addAll(_parse(data));
  }

  /// [StudentScore] 정보를 파일에 저장합니다
  void save(StudentScore score, [String filePath = 'result.txt']) {
    FileUtil.saveFile(filePath, score.toString());
  }

  /// 학생 이름을 입력받아 해당 학생의 [StudentScore]를 반환합니다
  /// 데이터에 존재하는 올바른 이름을 입력할 때까지 반복하여 실행됩니다
  StudentScore promptName() {
    while (true) {
      print("어떤 학생의 통계를 확인하시겠습니까?");
      String? name = stdin.readLineSync();
      var score = _findByName(name);
      if (score != null) {
        return score;
      }
    }
  }

  /// 사용자 입력을 받아 `메뉴 방식`으로 기능을 선택할 수 있도록 합니다
  /// 사용자가 `1`을 입력하면, 우수생(가장 높은 평균 점수를 가진 학생)의 정보를 출력합니다
  /// 사용자가 `2`를 입력하면, 전체 학생들의 평균 점수를 계산하여 출력합니다
  /// 사용자가 `3` 또는 잘못된 입력 값을 넣는 경우 프로그램을 종료하며, 그 전까지는 반복 실행합니다
  void promptMenu() {
    print('''
메뉴를 선택하세요:
1. 우수생 출력
2. 전체 평균 점수 출력
3. 종료
''');
    var enteredNumber = int.tryParse(stdin.readLineSync() ?? '0');
    switch (enteredNumber) {
      case 1:
        var score = getTopScore();
        print('우수생: ${score.name} (점수: ${score.point})');
        promptMenu();
        return;
      case 2:
        print('전체 평균 점수: ${getAverageScore()}');
        promptMenu();
        return;
      default:
        print('프로그램을 종료합니다.');
        return;
    }
  }

  StudentScore? _findByName(String? name) {
    try {
      return _scores.firstWhere((score) => score.name == name);
    } catch (e) {
      print('잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.');
      return null;
    }
  }

  /// '<이름>,<점수>' 형식의 문자열 데이터를 `List<StudentScore>`로 변환합니다
  ///
  /// 입력 데이터 예시:
  /// ```
  /// 홍길동,90
  /// 김철수,80
  /// ```
  ///
  /// 입력 데이터에서 파싱된 [StudentScore] 객체들의 리스트를 반환합니다
  ///
  /// 형식이 맞지 않는 줄이 있으면 [FormatException]을 발생시킵니다
  List<StudentScore> _parse(String data) {
    return data.split('\n').map((line) {
      var parts = line.split(',');

      if (parts.length != 2) {
        throw FormatException('잘못된 데이터 형식: $line');
      }

      var name = parts[0];
      var point = int.tryParse(parts[1]);

      if (point == null) {
        throw FormatException('점수가 숫자가 아닙니다: $point');
      }

      return StudentScore(name: name, point: point);
    }).toList();
  }
}
