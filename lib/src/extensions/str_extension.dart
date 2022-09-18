extension StrFormat on String {
  String get firstCapital {
    List<String> values = split('');
    values[0] = values[0].toUpperCase();
    return values.join();
  }

  String get durationFormat {
    int? duration = int.tryParse(this);
    if (duration == null) return this;
    int hours = duration ~/ 3600000;
    duration = duration % 3600000;
    int minutes = duration ~/ 60000;
    duration = duration % 60000;
    int seconds = duration;
    if (hours > 0) {
      if (minutes > 0) {
        return "$hours hr $minutes mins";
      } else {
        return "$hours hr";
      }
    }
    if (minutes > 0) {
      return "$minutes mins";
    }
    return "$seconds s";
  }
}
