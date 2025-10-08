import 'assignment_challenge_data.dart';
import 'lotto_util.dart';

void main() {
  var myLottoNumbers = getLottoNumbers();
  var matchCount = countMatches(winningLottoNumbers, myLottoNumbers);
  var rank = getLottoRank(matchCount);
  print(getLottoResult(rank));
}