List<int> generateListUntilMax(int? max) {
  List<int> list = List.empty(growable: true);
  for (var i = 1; i <= max!; i++) {
    list.add(i);
  }
  return list;
}
