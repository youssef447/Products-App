enum SortEnum {
  name,
  time,
}

extension SortEnumExtension on SortEnum {
  String get getName {
    switch (this) {
      case SortEnum.name:
        return 'Name';
      case SortEnum.time:
        return 'Time';
    }
  }
}
