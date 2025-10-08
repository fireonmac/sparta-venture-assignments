import 'score_model.dart';

class StudentScore extends Score {
  String name;

  StudentScore({required super.point, required this.name});

  @override
  void showInfo() {
    print(toString());
  }

  @override
  String toString() {
    return '이름: $name, 점수: $point';
  }
}
