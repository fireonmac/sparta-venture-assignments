import 'score_model.dart';

class StudentScore extends Score {
  String name;

  StudentScore({required super.point, required this.name});

  void showInfo() { 
    print('이름: $name, 점수: $point');
  }
}
