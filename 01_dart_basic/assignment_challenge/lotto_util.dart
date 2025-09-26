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

T pickRandomElementFromList<T>(List<T> list) {
  return list[Random().nextInt(list.length)];
}

int countMatches(List<int> list1, List<int> list2) {
  return list1.toSet().intersection(list2.toSet()).length;
}

List<int> getLottoNumbers([int limit = 45, int count = 6]) {
  var availableNumbers = List.generate(limit, (index) => index + 1);
  List<int> pickedNumbers = [];
  while (pickedNumbers.length < count) {
    var nextPick = pickRandomElementFromList(availableNumbers);
    if (!pickedNumbers.contains(nextPick)) {
      pickedNumbers.add(nextPick);
    }
  }
  return pickedNumbers;
}
