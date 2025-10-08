import 'dart:io';

class FileUtil {
  static String loadFile(String filePath) {
    try {
      final file = File(filePath);
      return file.readAsStringSync();
    } catch (e) {
      print("파일 데이터를 불러오는 데 실패했습니다: $e");
      exit(1);
    }
  }

  static void saveFile(String filePath, String content) {
    try {
      final file = File(filePath);
      file.writeAsStringSync(content);
      print("저장이 완료되었습니다.");
    } catch (e) {
      print("저장에 실패했습니다: $e");
    }
  }
}
