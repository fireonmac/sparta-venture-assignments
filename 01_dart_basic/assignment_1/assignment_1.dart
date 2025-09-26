String getGradeByScore(int score) {
  if (score >= 90) {
    return 'A';
  } else if (score >= 80) {
    return 'B';
  } else {
    return 'C';
  }
}

void printTestResult(int score) {
  var grade = getGradeByScore(score);
  print('이 학생의 점수는 $score점 이며, 등급은 $grade등급입니다!');
}

void main() {
  const score = 84;
  printTestResult(score);
}
