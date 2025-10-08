import 'dart:io';
import 'package:dart_advanced/assignment_1.dart' as assignment1;
import 'package:dart_advanced/assignment_2.dart' as assignment2;
import 'package:dart_advanced/assignment_3.dart' as assignment3;

void main() {
  print('''
실행할 문제의 번호를 입력해주세요.
1: (필수) 사용자로부터 입력 받아 학생 점수 확인 기능
2: (필수) 프로그램 종료 후, 결과를 파일에 저장하는 기능
3: (도전) 학생들 중 우수생을 출력하는 기능, 전체 평균 점수를 출력하는 기능
''');

  var selectedNumber = int.parse(stdin.readLineSync() ?? '0');
  switch (selectedNumber) {
    case 1:
      assignment1.solution();
      return;
    case 2:
      assignment2.solution();
      return;
    case 3:
      assignment3.solution();
      return;
    default:
      print('번호를 잘못 입력하셨습니다.');
  }
}
