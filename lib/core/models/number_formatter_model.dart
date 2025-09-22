class NumberFormatter {
  static String format(int number) {
    if (number < 10000) {
      return formatWithCommas(number);
    } else if (number < 1000000) {
      return formatInK(number);
    } else {
      return formatInM(number);
    }
  }

  static String formatWithCommas(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  static String formatInK(int number) {
    final value = number / 1000;
    if (value == value.floorToDouble()) {
      return '${value.toInt()}k'; // e.g. 10k
    } else {
      return '${value.toStringAsFixed(1)}k';
    }
  }

  static String formatInM(int number) {
    final value = number / 1000000;
    if (value == value.floorToDouble()) {
      return '${value.toInt()}M';
    } else {
      return '${value.toStringAsFixed(1)}M';
    }
  }
}
