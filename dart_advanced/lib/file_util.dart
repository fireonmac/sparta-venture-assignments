import 'dart:io';

String loadFile(String filePath) {
  String result = '';

  try {
    final file = File(filePath);
    final lines = file.readAsLinesSync();

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      result += line;
      
      // 마지막 줄이 아닌 경우 각 라인마다 개행
      if (i != lines.length - 1) {
        result += '\n'; 
      }
    }
    
  } catch (e) {
    print("파일 데이터를 불러오는 데 실패했습니다: $e");
    exit(1);
  }

  return result;
}

void saveFile(String filePath, String content) {
  try {
    final file = File(filePath);
    file.writeAsStringSync(content);
    print("저장이 완료되었습니다.");
  } catch (e) {
    print("저장에 실패했습니다: $e");
  }
}
