import 'dart:io';
import 'package:dart_advanced/assignment_1.dart' as assignment1;
import 'package:dart_advanced/assignment_2.dart' as assignment2;

void main() {
  print('''
실행할 문제의 번호를 입력해주세요.
1: (필수) 사용자로부터 입력 받아 학생 점수 확인 및 종료 후 결과를 파일에 저장하는 기능
2: (도전) 학생들 중 우수생을 출력하는 기능, 전체 평균 점수를 출력하는 기능
''');

  var enteredNumber = int.tryParse(stdin.readLineSync() ?? '0');
  switch (enteredNumber) {
    case 1:
      assignment1.solution();
      return;
    case 2:
      assignment2.solution();
      return;
    default:
      print('번호를 잘못 입력하셨습니다.');
  }
}
