import 'assignment_challenge_data.dart';
import 'lotto_util.dart';

void main() {
  var myLottoNumbers = getLottoNumbers();
  var matchCount = countMatches(winningLottoNumbers, myLottoNumbers);
  var rank = getLottoRank(matchCount);
  var prevLottoNumbers = myLottoNumbers;
  myLottoNumbers = [];

  print('''
------------------------------------------
도전 문제 
발급한 로또 번호: $prevLottoNumbers
${getLottoResult(rank)}
현재 발급한 로또 번호: $myLottoNumbers
------------------------------------------
''');
}
