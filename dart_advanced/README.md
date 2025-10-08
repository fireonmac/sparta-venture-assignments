# Dart Advanced Assignments

## 🚀 시작하기

**프로그램 실행**

```bash
dart run
# 과제 1 실행 시 1 입력 후 엔터
1
# 과제 2 실행 시 2 입력 후 엔터
2
```

## 📁 프로젝트 구조

```
dart_advanced/
├── bin/
│   └── dart_advanced.dart      # 메인 실행 파일, 실행할 과제를 번호로 입력하여 선택
├── lib/
│   ├── assignment_1.dart       # 필수과제: 사용자로부터 입력 받아 학생 점수 확인 및 프로그램 종료 후, 결과를 파일에 저장하는 기능
│   ├── assignment_2.dart       # 도전과제: 학생들 중 우수생을 출력하는 기능, 전체 평균 점수를 출력하는 기능
│   ├── score_model.dart        # 점수 모델 (기본 클래스)
│   ├── student_score_model.dart # 학생 점수 모델 (상속)
│   ├── file_util.dart          # 파일 입출력 유틸 클래스
│   └── student_score_manager.dart       # 학생 점수 기능을 관리하는 클래스
└── students.txt                # 학생 데이터 파일
```
