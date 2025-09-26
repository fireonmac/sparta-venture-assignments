import 'dart:math';

String getLottoResult(int? rank) {
  if (rank != null) {
    return '당첨 여부: $rank';
  } else {
    return '당첨 여부: 당첨 실패!';
  }
}

int? getLottoRank(int matchCount) {
  switch (matchCount) {
    case 6:
    case 5:
      return 1;
    case 4:
      return 2;
    default:
      return null;
  }
}

int countMatches(List<int> list1, List<int> list2) {
  return list1.toSet().intersection(list2.toSet()).length;
}

List<int> getLottoNumbers([int limit = 45, int count = 6]) {
  Set<int> picked = Set();
  while (picked.length < count) {
    var nextPick = Random().nextInt(limit) + 1;
    if (!picked.contains(nextPick)) {
      picked.add(nextPick);
    }
  }
  return picked.toList();
}
